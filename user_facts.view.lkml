view: user_facts {
  derived_table: {
    sql: SELECT
        user_id,
        COUNT(DISTINCT order_id) AS lifetime_order_count,
        SUM(sale_price) AS lifetime_revenue,
        MIN(NULLIF(created_at, 0)) AS first_order_date,
        MAX(NULLIF(created_at, 0)) AS latest_order_date
      FROM public.order_items
      GROUP BY 1
 ;;
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_count {
    type: number
    sql: ${TABLE}.lifetime_order_count ;;
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

  measure: avg_lifetime_orders {
    type: average
    sql: ${lifetime_order_count} ;;
  }

  measure: avg_lifetime_revenue {
    type: average
    sql: ${lifetime_revenue} ;;
  }

  set: detail {
    fields: [user_id, lifetime_order_count, lifetime_revenue, first_order_date_time, latest_order_date_time]
  }
}
