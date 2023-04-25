const { Sequelize } = require('sequelize');

const sequelize = new Sequelize({
    dialect: 'sqlite',
    storage: "/home/workstation/Projetos/dweb2/Patchoulis_Library/db.sqlite"
})
//const { DataTypes } = require("sequelize");

db = {}

db.Sequelize = Sequelize
db.sequelize = sequelize

module.exports = db