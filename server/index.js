// Importando o express
const express = require('express');
const mongoose = require('mongoose');
// Importando rotas
const authRouter = require('./routes/auth');

// Criando uma instância do express
const app = express();
const PORT = 8081;
const DB = "mongodb+srv://aalexsd:polimark25@cluster0.d1wiiax.mongodb.net/?retryWrites=true&w=majority";

// Middleware
app.use(express.json());
app.use(authRouter);

// Conectando ao banco de dados
mongoose.connect(DB).then(() => {
    console.log("Conectado ao banco de dados");
}).catch((err) => {
    console.log(`Erro ao conectar ao banco de dados: ${err}`);
})

// Criando uma API
app.listen(PORT, "0.0.0.0", function () {
    console.log(`Servidor rodando na porta ${PORT}`);
});