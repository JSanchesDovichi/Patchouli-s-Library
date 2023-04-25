//const db = require("../../database.js")
const Conteudos = require("./model")

exports.create = (req, res) => {
    Conteudos.create({
    }).then((user) => {
        res.send(user)
    })
}

exports.findAll = (req, res) => {
    Conteudos.findAll().then( users => {
        res.send(users)
    })
}

exports.update = (req, res) => {
    Conteudos.update({
        
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
    Conteudos.destroy(
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