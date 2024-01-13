const mongoose = require('mongoose');

const petsSchema = mongoose.Schema({
    idUsuario: {
        type: String,
        required: [true, "O idUsuario é obrigatório"],
        trim: true,
    },
    tipoPet: {
        type: String,
        required: [true, "O tipoPet é obrigatório"],
        trim: true,
    },
    nomePet: {
        type: String,
        required: [true, "O nomePet é obrigatório"],
        trim: true,
    },
    raca: {
        type: String,
        required: [true, "A raca é obrigatória"],
        trim: true,
    },
    cor: {
        type: String,
        required: [true, "A cor é obrigatória"],
        trim: true,
    },
    peso: {
        type: String,
        required: [true, "O peso é obrigatório"],
        trim: true,
    },
    idade: {
        type: String,
        required: [true, "A idade é obrigatória"],
        trim: true,
    },
});

const Pet = mongoose.model("Pet", petsSchema);
module.exports = Pet;