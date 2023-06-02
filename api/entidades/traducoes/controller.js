//const db = require("../../database.js")
const Traducoes = require("./model")

exports.create = (req, res) => {
    if (req.body.lingua == null || req.body.conteudo == null) {
        res.status(400).send('Dados de traduçãoo inválidos!')
    } else {
        Traducoes.create({
            lingua: req.body.lingua,
            conteudo: req.body.conteudo
        }).then((user) => {
            res.send("Tradução criada com sucesso!")
        })
    }
}

exports.findAll = (req, res) => {
    Traducoes.findAll().then(users => {
        res.send(users)
    })
}

exports.update = (req, res) => {
    if (req.body.lingua == null || req.body.conteudo == null) {
        res.status(400).send('Dados de traduçãoo inválidos!')
    } else {
        Traducoes.update({
            lingua: req.body.lingua,
            conteudo: req.body.conteudo
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
}

exports.delete = (req, res) => {
    Traducoes.destroy(
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