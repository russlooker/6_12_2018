view: user_fact {
  derived_table: {
    sql: select user_id,
      count(distinct order_id) as lifetime_orders,
      sum(sale_price) as lifetime_revenue,
      min(nullif(created_at,0)) as first_order,
      max(nullif(created_at,0)) as latest_order
      from public.order_items
      group by user_id
       ;;
  }


  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: latest_order {
    type: time
    sql: ${TABLE}.latest_order ;;
  }

measure: avg_lifetime_revenue {
  type: average
  sql: ${lifetime_revenue} ;;
}

measure: avg_lifetime_orders {
  type:  average
  sql: ${lifetime_orders} ;;
}

  set: detail {
    fields: [user_id, lifetime_orders, lifetime_revenue, first_order_time, latest_order_time]
  }
}
