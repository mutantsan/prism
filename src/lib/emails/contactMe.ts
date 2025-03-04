interface EmailParams {
    name: string;
    email: string;
    message: string;
}

export function welcomeEmail({ name, email, message }: EmailParams) {
    return `
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Contact Form Submission</title>
          <style>
            body {
              font-family: Arial, sans-serif;
              color: #333;
              max-width: 600px;
              margin: 0 auto;
            }
            .header {
              background-color: #f8f8f8;
              padding: 20px;
              text-align: center;
            }
            .content {
              padding: 20px;
            }
            .footer {
              font-size: 12px;
              text-align: center;
              padding: 20px;
              color: #999;
            }
          </style>
        </head>
        <body>
          <div class="header">
            <h1>Contact Form Submission</h1>
          </div>
          <div class="content">
            <p>A new contact form submission has been received.</p>
            <p>Name: ${name}</p>
            <p>Email: ${email}</p>
            <p>Message: ${message}</p>
          </div>
          <div class="footer">
            <p>© 2025 Your Company. All rights reserved.</p>
          </div>
        </body>
      </html>
    `;
}
