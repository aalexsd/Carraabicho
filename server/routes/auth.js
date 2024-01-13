const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcrypt');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");
const Profissional = require('../models/profissional');
const Pet = require('../models/pets');
const Agendamento = require('../models/agendamento');

authRouter.post('/api/signup', async (req, res)  => {
try {
        // Get user data from request
        const {nome, sobrenome, cpf, email, telefone, nasc, sexo, cep, endereco, nro, complemento, bairro, cidade, uf, isUsuario, senha} = req.body;

        const existingEmail =  await User.findOne({email});
        if(existingEmail){
            return res.status(400).json({message: "Email já cadastrado."});
        }

        const existingCpf =  await User.findOne({cpf});
        if(existingCpf){
            return res.status(400).json({message: "Cpf já cadastrado."});
        }

       const hashedPassowrd = await bcrypt.hash(senha, 8);
    
       var user = new User({
            nome,
            sobrenome,
            cpf,
            email,
            telefone,
            nasc,
            sexo,
            cep,
            endereco,
            nro,
            complemento,
            bairro,
            cidade, 
            uf,
            isUsuario,
            senha: hashedPassowrd,
        });
    
        user = await user.save();
        res.json({user});

} catch (error) {
    res.status(500).json({message: error.message});
}

});

authRouter.post('/api/signup/profissional', async (req, res)  => {
  try {
          // Get user data from request
          const {nome, sobrenome, cpf, email, telefone, nasc, sexo, cep, endereco, nro, complemento, bairro, cidade, uf, isUsuario, senha, valor, tipoProfissional} = req.body;
  
          const existingEmail =  await Profissional.findOne({email});
          if(existingEmail){
              return res.status(400).json({message: "Email já cadastrado."});
          }
  
          const existingCpf =  await Profissional.findOne({cpf});
          if(existingCpf){
              return res.status(400).json({message: "Cpf já cadastrado."});
          }
  
         const hashedPassowrd = await bcrypt.hash(senha, 8);
      
         var profissional = new Profissional({
              nome,
              sobrenome,
              cpf,
              email,
              telefone,
              nasc,
              sexo,
              cep,
              endereco,
              nro,
              complemento,
              bairro,
              cidade, 
              uf,
              isUsuario,
              valor,
              tipoProfissional,
              senha: hashedPassowrd,
          });
      
          profissional = await profissional.save();
          res.json({profissional});
  
  } catch (error) {
      res.status(500).json({message: error.message});
  }
  
  });

authRouter.post('/api/signin', async (req, res) => {
try {
    const {email, senha} = req.body;

    const user = await User.findOne({email});
    if (!user){
        return res.status(400).json({message: "Usuário não encontrado. Tente novamente."});
    }

    const isMatch = await bcrypt.compare(senha, user.senha);
    if (!isMatch){
        return res.status(400).json({message: "Senha incorreta. Tente novamente."});
    }

    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({token, ...user._doc});
} catch (error) {
    res.status(500).json({error: error.message});
}

});

authRouter.post('/api/signin/profissional', async (req, res) => {
  try {
      const {email, senha} = req.body;
  
      const profissional = await Profissional.findOne({email});
      if (!profissional){
          return res.status(400).json({message: "Usuário não encontrado. Tente novamente."});
      }
  
      const isMatch = await bcrypt.compare(senha, profissional.senha);
      if (!isMatch){
          return res.status(400).json({message: "Senha incorreta. Tente novamente."});
      }
  
      const token = jwt.sign({id: profissional._id}, "passwordKey");
      res.json({token, ...profissional._doc});
  } catch (error) {
      res.status(500).json({error: error.message});
  }
  
  });
  


authRouter.post('/verificar-usuario', async (req, res) => {
    try {
      const { cpf, email } = req.body;
  
      // Verifica se pelo menos um dos parâmetros está presente
      if (!cpf && !email) {
        return res.status(400).json({ error: 'É necessário fornecer CPF ou E-mail.' });
      }
  
      // Verifica se o CPF já está cadastrado, se o parâmetro estiver presente
      if (cpf) {
        const existingCPFUser = await User.findOne({cpf });
        if (existingCPFUser) {
          return res.json({ exists: true, message: 'CPF já cadastrado.' });
        }
      }
  
      // Verifica se o e-mail já está cadastrado, se o parâmetro estiver presente
      if (email) {
        const existingEmailUser = await User.findOne({email});
        if (existingEmailUser) {
          return res.json({ exists: true, message: 'E-mail já cadastrado.' });
        }
      }
  
      // Se chegou até aqui, o CPF e/ou e-mail não estão cadastrados
      res.json({ exists: false, message: 'CPF e/ou e-mail não cadastrados.' });
    } catch (error) {
      console.error(error);
      return res.status(500).json({ error: 'Erro interno do servidor' });
    }
  });

authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if(!token) return res.json(false);

        const isVerified = jwt.verify(token, "passwordKey");
        if(!isVerified) return res.json(false);

        const user = await User.findById(isVerified.id);
        if(!user) return res.json(false);

        res.json(true);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
    
    },);

authRouter.get('/profissionais/:tipoProfissional', async (req, res) => {
  try {
    const { tipoProfissional } = req.params;

    // Encontre todos os profissionais com base no tipo
    const profissionais = await Profissional.find({ tipoProfissional });

    res.json(profissionais);
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Erro interno do servidor' });
  }
});

authRouter.post('/pets', async (req, res) => {
  try {
    const { idUsuario, tipoPet, nomePet, raca, cor, peso,idade } = req.body;

    // Valide os dados antes de inserir no banco de dados
    if (!idUsuario || !tipoPet || !nomePet || !raca || !peso) {
      return res.status(400).json({
        error: 'Todos os campos são obrigatórios',
      });
    }

    // Adicione lógica para inserir o agendamento no banco de dados usando Sequelize
    const novoPet = await Pet.create({
      idUsuario,
      tipoPet,
      nomePet,
      raca,
      cor,
      peso,
      idade,
    });

    res.json({
      status: 'Pet criado com sucesso',
      idPet: novoPet.id,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      error: 'Erro interno do servidor',
    });
  }
});

authRouter.get('/pets/:idUsuario', async (req, res) => {
  try {
    const { idUsuario } = req.params;

    const pets = await Pet.find({idUsuario});

    res.json(pets);
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      error: 'Erro interno do servidor',
    });
  }
});


authRouter.post('/agendamento', async (req, res) => {
  try {
    const { idUsuario, idProfissional, nomeProfissional, titulo, data, pet,hora, descricao } = req.body;

    // Valide os dados antes de inserir no banco de dados
    if (!idUsuario || !idProfissional || !data || !hora || !descricao) {
      return res.status(400).json({
        error: 'Todos os campos são obrigatórios',
      });
    }

    // Adicione lógica para inserir o agendamento no banco de dados usando Sequelize
    const novoAgendamento = await Agendamento.create({
      idUsuario,
      idProfissional,
      nomeProfissional,
      titulo,
      data,
      hora,
      pet,
      descricao,
      status: false,
    });

    res.json({
      status: 'Agendamento criado com sucesso',
      idAgendamento: novoAgendamento.id,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      error: 'Erro interno do servidor',
    });
  }
});

authRouter.get('/agendamentos/usuario/:idUsuario', async (req, res) => {
  try {
    const { idUsuario } = req.params;

    const agendamentos = await Agendamento.find({
        idUsuario,
    });

    res.json(agendamentos);
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      error: 'Erro interno do servidor',
    });
  }
}); 



// get user data

authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({
        ...user._doc, token: req.token
    });
});

// Indica que não é um arquivo privado
module.exports = authRouter;   