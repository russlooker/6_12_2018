connection: "events_ecommerce"
persist_with: order_items

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: default {
  sql_trigger: select current_date ;;
  max_cache_age: "24 hours"
}

datagroup: order_items {
  sql_trigger: select max(created_at) from order_items ;;
  max_cache_age: "4 hours"
}




explore: order_items {
  persist_with: order_items
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: events {
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: user_summary {
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.id}=${user_summary.user_id} ;;
  }

  join: user_summary_native {
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.email}=${user_summary_native.email} ;;
  }

  join: order_facts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.order_id}=${order_facts.order_id} ;;
  }

}
