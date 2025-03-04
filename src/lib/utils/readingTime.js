/**
 * Calculate reading time in minutes for a given text
 *
 * @param {string} content - The content to calculate reading time for
 * @param {number} wordsPerMinute - Reading speed (default: 200 words per minute)
 *
 * @returns {number} Reading time in minutes
 */
export function calculateReadingTime(content, wordsPerMinute = 200) {
    // Remove HTML tags if the content contains HTML
    const text = content.replace(/<\/?[^>]+(>|$)/g, '');

    // Count words by splitting on whitespace
    const wordCount = text.trim().split(/\s+/).length;

    // Calculate reading time in minutes
    const readingTime = Math.ceil(wordCount / wordsPerMinute);

    // Return at least 1 minute for very short content
    return Math.max(1, readingTime);
}
