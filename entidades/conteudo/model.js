const db = require("../../database.js")
const {Model, DataTypes} = db.Sequelize

const sequelize = db.sequelize

class Conteudo extends Model {}
Conteudo.init({
}, {sequelize})

module.exports = Conteudo

/*
class Usuarios extends Model {}
Usuarios.init({
    email : {
        type : DataTypes.STRING
    },
    senha : {
        type: DataTypes.STRING
    }
}, {sequelize})
*/

//module.exports = Usuarios