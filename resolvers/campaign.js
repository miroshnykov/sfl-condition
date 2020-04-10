const {Campaign: Campaign} = require('../models')
const checkUser = require('../helper/perm')

module.exports = {
    Query: {
        campaign: (_, {id}, ctx) => {
            checkUser(ctx.user)
            return Campaign.get(id)
        },
    },
    Mutation: {
        addCampaign: async (_, {
            name,
            budgetTotal,
            budgetDaily,
            cpc,
            landingPage
        }, ctx) => {
            checkUser(ctx.user)

            let campaign = {}
            campaign.name = name
            campaign.budgetTotal = budgetTotal
            campaign.budgetDaily = budgetDaily
            campaign.cpc = cpc
            campaign.landingPage = landingPage
            campaign.user = ctx.user.email
            return await Campaign.add(campaign)
        },
        updateCampaign: async (_, {
            id,
            name,
            budgetTotal,
            budgetDaily,
            cpc,
            landingPage
        }, ctx) => {
            checkUser(ctx.user)

            let campaign = {}
            campaign.id = id
            campaign.name = name
            campaign.budgetTotal = budgetTotal
            campaign.budgetDaily = budgetDaily
            campaign.cpc = cpc
            campaign.landingPage = landingPage
            campaign.user = ctx.user.email
            return await Campaign.update(campaign)
        },
        updateCampaignName: async (_, {
            id,
            name
        }, ctx) => {
            checkUser(ctx.user)

            let campaign = {}
            campaign.id = id
            campaign.name = name
            campaign.user = ctx.user.email
            return await Campaign.updateName(campaign)
        },
        deleteCampaign: async (_, {
            campaignId
        }, ctx) => {
            checkUser(ctx.user)
            return await Campaign.del(campaignId)
        },
    }
}