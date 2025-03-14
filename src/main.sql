-- STEP 1: Create the posts table first
create table posts (
    id UUID primary key default gen_random_uuid (),
    title TEXT not null,
    slug TEXT not null unique,
    content TEXT not null,
    excerpt TEXT,
    featured_image_url TEXT,
    author_id UUID not null references auth.users (id) on delete CASCADE,
    status TEXT not null default 'draft' check (status in ('draft', 'published', 'archived')),
    is_featured BOOLEAN default false,
    view_count INTEGER default 0,
    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW() -- We'll add the search vector later after the table exists
);

-- Create indexes for the posts table
create index posts_slug_idx on posts (slug);

create index posts_author_id_idx on posts (author_id);

create index posts_is_featured_idx on posts (is_featured)
where
    is_featured = true;

-- STEP 2: Create the tags table
create table tags (
    id UUID primary key default gen_random_uuid (),
    name TEXT not null,
    slug TEXT not null unique
);

create index tags_slug_idx on tags (slug);

-- STEP 3: Create the post_tags junction table
create table post_tags (
    id UUID primary key default gen_random_uuid (),
    post_id UUID not null references posts (id) on delete CASCADE,
    tag_id UUID not null references tags (id) on delete CASCADE,
    constraint post_tag_unique unique (post_id, tag_id)
);

create index post_tags_post_id_idx on post_tags (post_id);

create index post_tags_tag_id_idx on post_tags (tag_id);

-- STEP 4: Create the user_roles table
create table user_roles (
    id UUID primary key default gen_random_uuid (),
    user_id UUID not null references auth.users (id) on delete CASCADE,
    role TEXT not null check (
        role in ('admin', 'editor', 'author', 'subscriber')
    ),
    created_at TIMESTAMPTZ not null default NOW(),
    updated_at TIMESTAMPTZ not null default NOW(),
    constraint user_role_unique unique (user_id, role)
);

create index user_roles_user_id_idx on user_roles (user_id);

-- STEP 5: Now add the search vector to posts table
alter table
    posts
add
    column search_vector TSVECTOR GENERATED ALWAYS as (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') || setweight(
            to_tsvector('english', coalesce(excerpt, '')),
            'B'
        ) || setweight(
            to_tsvector('english', coalesce(content, '')),
            'C'
        )
    ) STORED;

create index posts_search_idx on posts using GIN (search_vector);

-- STEP 6: Create all the helper functions
-- Function to update posts updated_at
create
or replace function update_updated_at_column () RETURNS TRIGGER as $ $ BEGIN NEW.updated_at = NOW();

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

-- Create a function to generate a slug from a title
CREATE
OR REPLACE FUNCTION generate_slug_from_title(title TEXT) RETURNS TEXT AS $ $ DECLARE slug TEXT;

BEGIN -- Convert to lowercase
slug := lower(title);

-- Replace spaces and special characters with hyphens
slug := regexp_replace(slug, '[^a-z0-9]', '-', 'g');

-- Replace multiple consecutive hyphens with a single hyphen
slug := regexp_replace(slug, '-+', '-', 'g');

-- Remove leading and trailing hyphens
slug := trim(
    both '-'
    from
        slug
);

RETURN slug;

END;

$ $ LANGUAGE plpgsql;

-- Create a trigger function to set the slug if it's NULL
CREATE
OR REPLACE FUNCTION set_post_slug() RETURNS TRIGGER AS $ $ BEGIN -- If slug is NULL or empty, generate from title
IF NEW.slug IS NULL
OR NEW.slug = '' THEN NEW.slug := generate_slug_from_title(NEW.title);

-- Ensure the slug is unique by adding a suffix if needed
DECLARE base_slug TEXT := NEW.slug;

counter INTEGER := 1;

slug_exists BOOLEAN;

BEGIN LOOP
SELECT
    EXISTS(
        SELECT
            1
        FROM
            posts
        WHERE
            slug = NEW.slug
            AND id != NEW.id
    ) INTO slug_exists;

EXIT
WHEN NOT slug_exists;

NEW.slug := base_slug || '-' || counter;

counter := counter + 1;

END LOOP;

END;

END IF;

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

-- Function to update user_roles updated_at
create
or replace function update_user_role_updated_at_column () RETURNS TRIGGER as $ $ BEGIN NEW.updated_at = NOW();

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

-- Function to update tags updated_at
create
or replace function update_tag_updated_at_column () RETURNS TRIGGER as $ $ BEGIN NEW.updated_at = NOW();

RETURN NEW;

END;

$ $ LANGUAGE plpgsql;

-- STEP 7: Create all the triggers
-- Trigger for posts
create trigger update_posts_updated_at BEFORE
update
    on posts for EACH row execute FUNCTION update_updated_at_column ();

CREATE TRIGGER set_post_slug_trigger BEFORE
INSERT
    OR
UPDATE
    ON posts FOR EACH ROW EXECUTE FUNCTION set_post_slug();

-- Trigger for user_roles
create trigger update_user_roles_updated_at BEFORE
update
    on user_roles for EACH row execute FUNCTION update_user_role_updated_at_column ();

-- Trigger for tags
create trigger update_tags_updated_at BEFORE
update
    on tags for EACH row execute FUNCTION update_tag_updated_at_column ();

-- STEP 8: Create helper functions for tags and roles
-- Helper function to add tags to posts
create
or replace function add_tag_to_post (post_id UUID, tag_name TEXT) RETURNS UUID as $ $ DECLARE tag_id UUID;

tag_slug TEXT;

result_id UUID;

BEGIN -- Create a slug from the tag name
tag_slug := lower(
    regexp_replace(tag_name, '[^a-zA-Z0-9]', '-', 'g')
);

-- Try to find existing tag
SELECT
    id INTO tag_id
FROM
    tags
WHERE
    slug = tag_slug;

-- If tag doesn't exist, create it
IF tag_id IS NULL THEN
INSERT INTO
    tags (name, slug)
VALUES
    (tag_name, tag_slug) RETURNING id INTO tag_id;

END IF;

-- Add the tag to the post if not already added
INSERT INTO
    post_tags (post_id, tag_id)
VALUES
    (post_id, tag_id) ON CONFLICT (post_id, tag_id) DO NOTHING RETURNING id INTO result_id;

RETURN result_id;

END;

$ $ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to assign role to user
create
or replace function assign_role_to_user (target_user_id UUID, role_name TEXT) RETURNS UUID as $ $ DECLARE result_id UUID;

BEGIN -- Validate role name
IF role_name NOT IN ('admin', 'editor', 'author', 'subscriber') THEN RAISE EXCEPTION 'Invalid role: %',
role_name;

END IF;

-- Assign role
INSERT INTO
    user_roles (user_id, role)
VALUES
    (target_user_id, role_name) ON CONFLICT (user_id, role) DO NOTHING RETURNING id INTO result_id;

RETURN result_id;

END;

$ $ LANGUAGE plpgsql SECURITY DEFINER;

-- Helper function to check if user has a role
create
or replace function has_role (user_id UUID, role_name TEXT) RETURNS BOOLEAN as $ $ BEGIN RETURN EXISTS (
    SELECT
        1
    FROM
        user_roles
    WHERE
        user_id = $ 1
        AND role = $ 2
);

END;

$ $ LANGUAGE plpgsql SECURITY DEFINER;

-- STEP 9: Set up Row Level Security (RLS)
-- Enable RLS on all tables
alter table
    posts ENABLE row LEVEL SECURITY;

alter table
    tags ENABLE row LEVEL SECURITY;

alter table
    post_tags ENABLE row LEVEL SECURITY;

alter table
    user_roles ENABLE row LEVEL SECURITY;

-- STEP 10: Create RLS policies for posts
-- Policy for authors to manage their own posts
create policy author_all_access on posts for all to authenticated using (author_id = auth.uid ()) with check (author_id = auth.uid ());

-- Policy for public to view published posts
create policy public_view_published on posts for
select
    to anon,
    authenticated using (status = 'published');

-- Policy for admin users
create policy admin_all_access on posts for all to authenticated using (
    exists (
        select
            1
        from
            user_roles
        where
            user_id = auth.uid ()
            and role = 'admin'
    )
);

-- STEP 11: Create RLS policies for tags
-- Policy for public to view tags
create policy public_view_tags on tags for
select
    to anon,
    authenticated using (true);

-- Policy for admins to manage tags
create policy admin_manage_tags on tags for all to authenticated using (
    exists (
        select
            1
        from
            user_roles
        where
            user_id = auth.uid ()
            and role = 'admin'
    )
);

-- STEP 12: Create RLS policies for post_tags
-- Policy for authors to manage tags for their own posts
create policy author_manage_post_tags on post_tags for all to authenticated using (
    exists (
        select
            1
        from
            posts
        where
            posts.id = post_tags.post_id
            and posts.author_id = auth.uid ()
    )
);

-- Policy for admin to manage all post tags
create policy admin_manage_post_tags on post_tags for all to authenticated using (
    exists (
        select
            1
        from
            user_roles
        where
            user_id = auth.uid ()
            and role = 'admin'
    )
);

-- Policy for public to view post tags
create policy public_view_post_tags on post_tags for
select
    to anon,
    authenticated using (
        exists (
            select
                1
            from
                posts
            where
                posts.id = post_tags.post_id
                and posts.status = 'published'
        )
    );

-- STEP 13: Create RLS policies for user_roles
-- Policy for users to view their own roles
create policy user_view_own_roles on user_roles for
select
    to authenticated using (user_id = auth.uid ());

-- Policy for admins to manage all roles
create policy admin_manage_roles on user_roles for all to authenticated using (
    exists (
        select
            1
        from
            user_roles ur
        where
            ur.user_id = auth.uid ()
            and ur.role = 'admin'
    )
);
