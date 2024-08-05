# Note-Taker App

## Tech Stack
- **Frontend**: React, React Router, Bootstrap
- **Backend**: Node.js, Express
- **Database**: MongoDB
- **Authentication**: JWT (JSON Web Tokens)
- **Logging**: Pino
- **Testing**: Mocha, Chai (backend); Jest (frontend)

## Third-Party Services
- Cloudinary for image uploads
- SonarQube for code quality analysis

## Setup and Installation
### Prerequisites
- Node.js (>= 14.x)
- MongoDB

### Installation
1. **Clone the repository**
    ```sh
    git clone https://github.com/Fahd011/Fahd-mern-10pshine.git
    cd Fahd-mern-10pshine
    ```

2. **Backend Setup**
    ```sh
    cd backend
    npm install
    ```

3. **Frontend Setup**
    ```sh
    cd ../frontend
    npm install
    ```

4. **Environment Variables**
    Create a `.development.env` file in the `backend` directory with the following variables:
   - `PORT`: Port number for the backend server
   - `MONGO_URI`: MongoDB connection string
   - `SECRET`: JWT secret for authenticatio
     
    Also create a `.env` file in the `backend` directory for the testing environment with the following variables:
   - `PORT`: Port number for the backend server
   - `MONGO_URI`: MongoDB connection string for the test database
   - `SECRET`: JWT secret for authenticatio

6. **Run the Application**
    - Start the backend server
        ```sh
        cd backend
        npm start
        ```
    - Start the frontend development server
        ```sh
        cd ../frontend
        npm run dev
        ```

## Testing
### Backend Testing
- Run Mocha/Chai tests
    ```sh
    cd backend
    npm test
    ```

### Frontend Testing
- Run Jest tests
    ```sh
    cd frontend
    npm test
    ```


## Additional Features and Information

- Markdown support for writing notes
- User profile page
