//const db = require("../../database.js")
const Traducoes = require("./model")

exports.create = (req, res) => {
    Traducoes.create({
        lingua : req.body.lingua,
        conteudo : req.body.conteudo
    }).then((user) => {
        res.send(user)
    })
}

exports.findAll = (req, res) => {
    Traducoes.findAll().then( users => {
        res.send(users)
    })
}

exports.update = (req, res) => {
    Traducoes.update({
        lingua: "en-us",
        conteudo: "String aleatória"
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
    Traducoes.destroy(
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