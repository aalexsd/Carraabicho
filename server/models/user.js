const mongoose = require('mongoose');
const { DataTypes } = require('sequelize');

const userSchema = mongoose.Schema({
    nome: {
        type: String,
        required: [true, "O nome é obrigatório"],
        trim: true,
    },
    sobrenome: {
        type: String,
        required: [true, "O sobrenome é obrigatório"],
        trim: true,
    },
    cpf: {
        type: String,
        required: [true, "O CPF é obrigatório"],
        trim: true,
        unique: true
    },
    email: {
        type: String,
        required: [true, "O email é obrigatório"],
        trim: true,
        validate: {
            validator: (value) => {
                const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Insira um email válido",
        },
        unique: true,
    },
    telefone:{
        type: String,
        required: [true, "O telefone é obrigatório"],
        trim: true,
    },
    nasc:{
        type: String,
        required: [true, "A data de nascimento é obrigatória"],
    },
    sexo:{
        type: String,
        required: [true, "O sexo é obrigatório"],
        trim: true,
    },
    cep:{
        type: String,
        required: [true, "O CEP é obrigatório"],
        trim: true,
    },
    endereco:{
        type: String,
        required: [true, "O endereço é obrigatório"],
        trim: true,
    },
    nro:{
        type: String,
        required: [true, "O número é obrigatório"],
        trim: true,
    },
    complemento:{
        type: String,
        required: false,
        trim: true,
    },
    bairro: {
        type: String,
        required: [true, "O bairro é obrigatório"],
        trim: true,
    },
    cidade:{
        type: String,
        required: [true, "A cidade é obrigatória"],
        trim: true,
    },
    uf:{
        type: String,
        required: [true, "O estado é obrigatório"],
        trim: true,
    },
    senha: {
        type: String,
        required: [true, "A senha é obrigatória"],
        trim: true,
    },
    isUsuario:{
        type: String,
        required: [true, "O tipo de usuário é obrigatório"],
        trim: true,
    },
    type: {
        type: String,
        default: "user",
    }
});

const User = mongoose.model("User", userSchema);
module.exports = User;