Sequel.migration do
  up do
    create_table :transactions do
      Date :date
      String :description
      String :original_description
      BigDecimal :amount
      String :transaction_type
      String :category
      String :account_name
      String :labels
      String :notes
    end
  end
  
  down do
    drop_table
  end
end
