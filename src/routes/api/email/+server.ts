// src/routes/api/email/+server.ts
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import nodemailer from 'nodemailer';
import type SMTPTransport from 'nodemailer/lib/smtp-transport';
import { welcomeEmail } from "$lib/emails/contactMe";
import { EMAIL_HOST, EMAIL_PORT, EMAIL_SECURE, EMAIL_USER, EMAIL_PASSWORD, EMAIL_TO } from '$env/static/private';

export const POST: RequestHandler = async (event) => {
    const body = await event.request.text();
    const { name, email, message } = JSON.parse(body);

    let transportData: SMTPTransport.Options = {
        host: EMAIL_HOST,
        port: Number(EMAIL_PORT),
        secure: EMAIL_SECURE === 'true',
    };

    if (EMAIL_USER && EMAIL_PASSWORD) {
        transportData = {
            ...transportData,
            auth: {
                user: EMAIL_USER,
                pass: EMAIL_PASSWORD
            }
        };
    }

    try {
        await nodemailer.createTransport(transportData).sendMail({
            from: email,
            to: EMAIL_TO,
            subject: `New contact from ${name}`,
            html: welcomeEmail({ name, email, message })
        });

        return json({ success: true });
    } catch (error) {
        console.error('Email error:', error);
        return json(
            {
                success: false,
                error: error instanceof Error ? error.message : 'Unknown error'
            },
            { status: 500 }
        );
    }
};
