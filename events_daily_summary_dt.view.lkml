view: events_daily_summary {
  derived_table: {
    sql: SELECT
         DATE_TRUNC('day',created_at) AS time
        ,city
        ,country
        ,event_type
        ,traffic_source
        ,browser
        ,os
        ,uri
        ,COUNT(*)                AS count
        ,COUNT(DISTINCT user_id) AS distinct_user_count
        ,COUNT(DISTINCT session_id) AS distinct_session_count
      FROM PUBLIC.EVENTS
      GROUP BY 1,2,3,4,5,6,7,8
       ;;
  }
}
