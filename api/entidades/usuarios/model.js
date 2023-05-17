const db = require("../../database.js")
const {Model, DataTypes} = db.Sequelize

const sequelize = db.sequelize

class Usuarios extends Model {}
Usuarios.init({
    email : {
        type : DataTypes.STRING
    },
    senha : {
        type: DataTypes.STRING
    }
}, {sequelize})

module.exports = Usuarios