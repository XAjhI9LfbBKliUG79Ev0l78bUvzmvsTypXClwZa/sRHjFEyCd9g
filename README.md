# Адвокат Шкода Алексей Игоревич

## Overview

This project is the source code for the personal website of attorney Alexey Igorevich Shkoda. The website is a single-page application built with Vue.js and Vite.

## Local Development

To run the project locally, you need to have Node.js and pnpm installed.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/lawshkoda.ru.git
    cd lawshkoda.ru
    ```

2.  **Install dependencies:**
    ```bash
    pnpm install
    ```

3.  **Run the development server:**
    ```bash
    pnpm dev
    ```

The application will be available at `http://localhost:5173`.

## Docker

You can also build and run the application using Docker.

1.  **Build the Docker image:**
    ```bash
    docker build -t lawshkoda .
    ```

2.  **Run the Docker container:**
    ```bash
    docker run -d -p 8080:80 lawshkoda
    ```

The application will be available at `http://localhost:8080`.
