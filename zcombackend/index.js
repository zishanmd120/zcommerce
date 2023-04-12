const app = require("./app");
const db = require('./config/db')

const port = 4000;

app.listen(port,()=>{
    console.log(`Server Listening on Port http://localhost:${port}`);
})