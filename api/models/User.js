const { knex, Model } = require("../../db");
const { hash, compare } = require("bcrypt");

const SALT_ROUNDS = 10;

class User extends Model{
    static get tableName(){
        return "User"
    }

    static get relationMappings(){
        const Driver=require("./Driver.js");
        const Passenger=require("./Passenger.js");

        return {
            driver: {
                relation: Model.HasManyRelation,
                modelClass: Driver,
                join:{
                    from: "User.id",
                    to: "Driver.userId"
                },
            },

            passenger: {
                relation: Model.HasManyRelation,
                modelClass: Passenger,
                join:{
                    from: "User.id",
                    to: "Passenger.passengerId"
                },
            }
        }
    }
    getDrivers(){
        return this.$relatedQuery("driver")
        .$relatedQuery("user")
      .select("firstName")
      .then((theUser) => {
        return theUser;
      })
      .catch((err) => {
        console.log(err);
      });
    }

    // eslint-disable-next-line no-unused-vars
    async $beforeInsert(queryContext) {
      this.password = await hash(this.password, SALT_ROUNDS);
    }
    async $beforeUpdate(opt, queryContext) { //ADDED THIS AND CHANGED BUTTON TYPES TO PASSWORD
      this.password = await hash(this.password, SALT_ROUNDS);
      return super.$beforeUpdate(opt, queryContext);
    }

    async verifyPassword(plainTextPassword) {
      return compare(plainTextPassword, this.password);
    }
}

module.exports = User;
