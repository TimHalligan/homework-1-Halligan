// from data.js
var tableData = data;

// Get a reference to the table body
var tbody = d3.select("tbody");

// Loop Through `data` and console.log each tableData object
data.forEach(function(tableData) {
  console.log(tableData);
});

// Use d3 to append one table row `tr` for each tableData object
data.forEach(function(tableData) {
  console.log(tableData);
  var row = tbody.append("tr");
});

// Use `Object.entries` to console.log each tableData value
data.forEach(function(tableData) {
  console.log(tableData);
  var row = tbody.append("tr");

  Object.entries(tableData).forEach(function([key, value]) {
    console.log(key, value);
  });
});

// Use d3 to append 1 cell per tableData value
data.forEach(function(tableData) {
  console.log(tableData);
  var row = tbody.append("tr");

  Object.entries(tableData).forEach(function([key, value]) {
    console.log(key, value);
// Append a cell to the row for each value in the tableData object
    var cell = tbody.append("td");
  });
});

// Step 5: Use d3 to update each cell's text with tableData values
data.forEach(function(tableData) {
  console.log(tableData);
  var row = tbody.append("tr");
  Object.entries(tableData).forEach(function([key, value]) {
    console.log(key, value);
// Append a cell to the row for each value in thge tableData object
    var cell = tbody.append("td");
    cell.text(value);
  });
});



// Assign the data from `data.js` to a descriptive variable
var Sightings = data;

// Select the submit button
var submit = d3.select("#submit");

submit.on("click", function() {

  // Prevent the page from refreshing
  d3.event.preventDefault();

  // Select the input element and get the raw HTML node
  var inputElement = d3.select("#datetime");

  // Get the value property of the input element
  var inputValue = inputElement.property("value");

  console.log(inputValue);
  console.log(Sightings);

  var filteredData = Sightings.filter(sight => sight.Date === inputValue);

  console.log(filteredData);
});








































// BONUS: Refactor to use Arrow Functions!
// data.forEach((tableData) => {
//  var row = tbody.append("tr");
//  Object.entries(tableData).forEach(([key, value]) => {
//    var cell = tbody.append("td");
//    cell.text(value);
//  });
// });


 // displayData(tableData)

// var inputText = d3.select("#date")
// var button = d3.select("filter-btn")
//
// // filter data with desired date
// function changeHandler(){
//     d3.event.preventDefault();
//     console.log(inputText.property("value"));
//     var new_table = tableData.filter(sighting => sighting.datetime===inputText.property("value"))
//     displayData(new_table)
// }
//
// // event listener to handle change and click
// inputText.on("change", changeHandler)
// button.on("click", changeHandler)


// // Getting a reference to the button on the page with the id property set to `click-me`
// var button = d3.select("#click-me");
//
// // Getting a reference to the input element on the page with the id property set to 'input-field'
// var inputField = d3.select("#input-field");
//
// // This function is triggered when the button is clicked
// function handleClick() {
//  console.log("A button was clicked!");
//
//  // We can use d3 to see the object that dispatched the event
//  console.log(d3.event.target);
// }
//
// // We can use the `on` function in d3 to attach an event to the handler function
// button.on("click", handleClick);
//
// // You can also define the click handler inline
// button.on("click", function() {
//  console.log("Hi, a button was clicked!");
//  console.log(d3.event.target);
// });
//
// // Event handlers are just normal functions that can do anything you want
// button.on("click", function() {
//  d3.select(".giphy-me").html("<img src='https://gph.to/2Krfn0w' alt='giphy'>");
// });
//
// // Input fields can trigger a change event when new text is entered.
// inputField.on("change", function() {
//  var newText = d3.event.target.value;
//  console.log(newText);
// });
//
