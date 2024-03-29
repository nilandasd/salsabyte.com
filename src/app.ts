import express from "express";
import path from "path";
import morgan from "morgan";
import router from './routes/routes';

const app = express();

app.set( "views", path.join( __dirname, "views" ) );
app.set( "view engine", "ejs" );

if (process.env.NODE_ENV !== "production")  {
  app.use(express.static("public/dist"));
  app.use(morgan('combined'));
}

app.use('/', router);

export default app;
