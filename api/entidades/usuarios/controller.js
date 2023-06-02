//const db = require("../../database.js")
const Usuarios = require("./model")

exports.create = (req, res) => {
    if (req.body.email == null || req.body.senha == null) {
        res.status(400).send('Dados de cadastro inválidos!')
    } else {

        Usuarios.create({
            email: req.body.email,
            senha: req.body.senha
        }).then((user) => {
            res.send("Usuário criado com sucesso!")
        })
    }
}

exports.findAll = (req, res) => {
    Usuarios.findAll().then(users => {
        res.send(users)
    })
}

exports.update = (req, res) => {
    if (req.body.email == null || req.body.senha == null) {
        res.status(400).send('Dados de atualização inválidos!')
    }

    Usuarios.update({
        email: req.body.email,
        senha: req.body.senha
    },
        {
            where: {
                id: req.params.id
            }
        }
    ).then(
        (ok) => {
            res.send("Atualizado com sucesso!")
        },
        (error) => {
            res.send("Erro ao atualizar!")
        }
    )
}

exports.delete = (req, res) => {
    Usuarios.destroy(
        {
            where: {
                id: req.params.id
            }
        }
    ).then(
        (ok) => {
            res.send("Apagado com sucesso!")
        },
        (error) => {
            res.send("Erro ao deletar!")
        }
    )
}