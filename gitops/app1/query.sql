SELECT 
  FirstName,
  LastName,
  AddressLine1,
  AddressLine2,
  City,
  State,
  ZipCode
FROM Customer c
WHERE c.State = "Pennsylvania";