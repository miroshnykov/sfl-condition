const {getLpOffers, create, update, del} = require('../db/lpOffers')

class LpOffers {

    static async getLpOffers(offerId) {
        return await getLpOffers(offerId)
    }

    static async create(data) {
        return await create(data)
    }

    static async update(data) {
        return await update(data)
    }

    static async del(data) {
        return await del(data)
    }


}

module.exports = {
    LpOffers,
};