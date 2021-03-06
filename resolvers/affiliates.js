const {Affiliates} = require('../models')
const checkUser = require('../helper/perm')
const {getDataCache, setDataCache} = require('../redis/redis')

module.exports = {
    Query: {
        affiliates: async (_, {}, ctx) => {
            checkUser(ctx.user)
            let affCache = await getDataCache(`affiliates`)
            if (affCache) {
                return affCache
            } else {
                let aff = await Affiliates.allAffiliates()
                await setDataCache(`affiliates`, aff)
                return aff
            }

        },
        getAffiliatesByFilter: async (_, {filter}, ctx) => {
            checkUser(ctx.user)
            return await Affiliates.getAffiliatesByFilter(filter)
        },
        getAffiliatesBySegmentId: async (_, {segmentId}, ctx) => {
            checkUser(ctx.user)
            return await Affiliates.getAffiliatesBySegmentId(segmentId)
        },
    },
}