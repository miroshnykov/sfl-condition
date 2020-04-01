let dbMysql = require('./mysqlDb').get()

const getCampaigns = async () => {

    try {
        let result = await dbMysql.query(` 
            SELECT c.id, 
                   c.name, 
                   c.status, 
                   c.budget_total as budgetTotal, 
                   c.budget_daily as budgetDaily, 
                   c.cpc, 
                   c.user,
                   c.landing_page as landingPage 
            FROM   sfl_advertiser_campaigns c 
            ORDER  BY c.date_added 
        `)
        await dbMysql.end()

        console.log('getHistoryBySegmentId count:', result.length)
        return result
    } catch (e) {
        console.log(e)
    }
}

const addCampaign = async (data) => {

    try {
        const {name, budgetTotal, budgetDaily, cpc, landingPage, user } = data

        let date = new Date()
        let dateAdd = ~~(date.getTime() / 1000)

        let result = await dbMysql.query(`INSERT INTO sfl_advertiser_campaigns (
            name,
            budget_total,
            budget_daily, 
            cpc, 
            landing_page,
            user, 
            date_added
        )
        VALUES (?,?,?,?,?,?,?)`, [
            name, budgetTotal, budgetDaily, cpc, landingPage, user, dateAdd])
        await dbMysql.end()
        return result
    } catch (e) {
        console.log(e)
    }
}

module.exports = {
    addCampaign,
    getCampaigns
}