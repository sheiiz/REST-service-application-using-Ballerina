import ballerina/http;

type FoodItem record {|
    readonly string id;
    string name;
    string available_quantity;
    string price;
    string category;
|};

type Invoice record {|
    readonly string invoice_id;
    string customer_id;
    string amount;
    string created_date;
    string details;
|};

service /restaurant on new http:Listener(9090) {

    resource function get fooditems() returns FoodItem[]|error {
        return foodItems.toArray();
    }

    resource function post fooditems(@http:Payload FoodItem fooditem) returns FoodItem|ConflictingRecordError {
        if foodItems.hasKey(fooditem.id) {
            return {
                body: {
                    errmsg: "FoodItem ID Already Exists"
                }
            };
        }
        foodItems.add(fooditem);
        return fooditem;
    }

    resource function put fooditems(@http:Payload FoodItem fooditem) returns FoodItem|InvalidIDError {
        FoodItem? food_record = foodItems[fooditem.id];

        if food_record is () {
            return {
                body: {
                    errmsg: "FoodItem record not found. Invalid ID"
                }
            };
        }

        food_record.name = fooditem.name;
        food_record.available_quantity = fooditem.available_quantity;
        food_record.price = fooditem.price;
        food_record.category = fooditem.category;

        return fooditem;
    }

    resource function delete fooditems/[string id]() returns string|InvalidIDError {
        if foodItems.hasKey(id) {
            _ = foodItems.remove(id);
            return "Food Item Deleted Successfully";
        }
        else {
            return {
                    body: {
                        errmsg: "FoodItem record not found. Invalid ID"
                    }
            };
        }
    }
}

table<FoodItem> key(id) foodItems = table [
    {id: "1", name: "Pizza", available_quantity: "10", price: "12.99", category: "Main Course"},
    {id: "2", name: "Burger", available_quantity: "20", price: "8.99", category: "Fast Food"}
];

public type ConflictingRecordError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidIDError record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};
