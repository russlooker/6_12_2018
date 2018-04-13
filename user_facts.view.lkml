view: user_facts {
  derived_table: {
    sql: SELECT
        user_id,
        COUNT(DISTINCT order_id) AS liftime_order_count,
        SUM(sale_price) AS lifetime_revenue,
        MIN(NULLIF(created_at, 0)) AS first_order_date,
        MAX(NULLIF(created_at, 0)) AS latest_order_date
      FROM public.order_items
      GROUP BY 1
 ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: liftime_order_count {
    type: number
    sql: ${TABLE}.liftime_order_count ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order_date {
    type: time
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: latest_order_date {
    type: time
    sql: ${TABLE}.latest_order_date ;;
  }

  set: detail {
    fields: [user_id, liftime_order_count, lifetime_revenue, first_order_date_time, latest_order_date_time]
  }
}
