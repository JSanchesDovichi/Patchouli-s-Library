const db = require("../../database.js")
const {Model, DataTypes} = db.Sequelize

const sequelize = db.sequelize

class Traducoes extends Model {}
Traducoes.init({
    lingua : {
        type : DataTypes.STRING
    },
    conteudo : {
        type: DataTypes.STRING
    }
}, {sequelize})

module.exports = Traducoes