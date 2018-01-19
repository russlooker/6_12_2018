view: user_order_facts {
  derived_table: {
    sql: select users.id as UserID,
      count(order_id) as LifetimeOrderCount,
      sum(sale_price) as LifetimeRev,
      min(order_items.created_at) as FirstOrderDate,
      max(order_items.created_at) as LastOrderDate
      from users
      left outer join order_items
      on users.id=order_items.user_id
      group by users.id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: userid {
    primary_key: yes
    type: number
    sql: ${TABLE}.userid ;;
  }

  dimension: lifetimeordercount {
    type: number
    sql: ${TABLE}.lifetimeordercount ;;
  }

  dimension: lifetimerev {
    type: number
    value_format_name: usd
    sql: ${TABLE}.lifetimerev ;;
  }

  dimension_group: firstorderdate {
    type: time
    timeframes: [date,time]
    sql: ${TABLE}.firstorderdate ;;
  }

  dimension_group: lastorderdate {
    type: time
    timeframes: [date,time]
    sql: ${TABLE}.lastorderdate ;;
  }

  set: detail {
    fields: [userid, lifetimeordercount, lifetimerev]
  }
}
