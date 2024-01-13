const mongoose = require('mongoose');
const { DATEONLY } = require('sequelize');

const agendamentoSchema = mongoose.Schema({
    idUsuario: {
        type: String,
        required: [true, "O idUsuario é obrigatório"],
        trim: true,
    },
    idProfissional: {
        type: String,
        required: [true, "O idProfissional é obrigatório"],
        trim: true,
    },
    nomeProfissional: {
        type: String,
        required: [true, "O nomeProfissional é obrigatório"],
        trim: true,
    },
    titulo: {
        type: String,
        required: [true, "O titulo é obrigatório"],
        trim: true,
    },
    data: {
        type: Date,
        required: [true, "A data é obrigatória"],
        trim: true,
    },
    hora: {
        type: String,
        required: [true, "A hora é obrigatória"],
        trim: true,
    },
    descricao: {
        type: String,
        required: [true, "A descricao é obrigatória"],
        trim: true,
    },
    pet: {
        type: String,
        required: [true, "O pet é obrigatório"],
        trim: true,
    },
});

const Agendamento = mongoose.model("Agendamento", agendamentoSchema);
module.exports = Agendamento;