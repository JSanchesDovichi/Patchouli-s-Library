//const db = require("../../database.js")
const Usuarios = require("./model")

exports.create = (req, res) => {
    Usuarios.create({
        email : req.body.email,
        senha : req.body.senha
    }).then((user) => {
        res.send(user)
    })
}

exports.findAll = (req, res) => {
    Usuarios.findAll().then( users => {
        res.send(users)
    })
}

exports.update = (req, res) => {
    Usuarios.update({
        email: "emailalterado@gmail.com",
        senha: "12345"
    },
    {
        where: {
            id: req.params.id
        }
    }
    ).then (
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
    ).then (
        (ok) => {
            res.send("Apagado com sucesso!")
        },
        (error) => {
            res.send("Erro ao deletar!")
        }
    )
}