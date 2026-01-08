const app =require('express')();
const PORT=8080;

app.use(express.json());
app.listen(PORT,()=>{console.log(`server is running on post ${PORT}`)});
