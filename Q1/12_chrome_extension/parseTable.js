function createPreviewValuesTable(headerChoice, exampleCount = 2) {
  var rows = document.querySelector('tbody.rc-table-tbody').childNodes;
  var errors = new Array();
  var headers = {
    "Life": ['policyYear', 'age', 'insurance', 'dividend', 'annualPremium', 'annualIncrease', 'totalPremium', 'csvTotal', 'csvGuaranteed'],
    "DI":   ['policyYear', 'age', 'monthlyBenefit', 'annualizedBenefit', 'annualPremium', 'annPremOutlay', 'dividend'],
    "Term": ['policyYear', 'age', 'insurance', 'maximumGuaranteed', 'scheduledPremium', 'totalScheduledPremium']
  }[headerChoice];
  var data = [];
  var invalid = false;
  // Parses in data from rows, once per example from ExampleCount
  for (var eg = 1; eg <= exampleCount; eg++) {
    rows.forEach((r) => {
  		var rowData = {"example": eg.toString()}; // Appends "example" column on table
  		for (var i = 0; i < r.cells.length; i++) {
  			rowData[headers[i]] = r.cells[i].innerText;
  	    }
  		data.push(rowData);
  	});
	}
	var colLimits = Array(headers.length + 1).fill(0);
	// Figure out the longest value for each column in the table (formatting)
	data.forEach((row) => {
		for (var i = 0; i < Object.keys(row).length; i++) {
			key = Object.keys(row)[i];
			if(row[key].length > colLimits[i])
				colLimits[i] = row[key].length;
			if(key.length > colLimits[i])
				colLimits[i] = key.length;
		}
	});
	// Create Table
	var out = '';
	// Table Headers
	try {
		for (var i = 0; i < colLimits.length; i++) {
			var header = Object.keys(data[0])[i];
			// Add spacing for prettify
			//                      v 1 extra for join() + 1 for after value
			var spaces = (new Array(2 + (colLimits[i] - header.length))).join(" ")
			//						                  ^ fill space based on longest column value
			out += `| ${header}${spaces}`;
			if(i == 0) { out += " "; } // Weird fix for first column not being spaced correctly.
		}
	} catch (TypeError) {
		errors.push("ERROR:  Looks like you're probably using the wrong headers!");
		invalid = true;
	}
	if(invalid) {
    errors.forEach((e) => console.error(e));
		return "ERROR:  Check the dev console!";
	}
	out += '|\n' // Finish header row
	// Table Body
	try {
		data.forEach((row) => {
			out += "| ";
			for (var i = 0; i < Object.keys(row).length; i++) {
				var key = Object.keys(row)[i];
				// Add spacing for prettify
				var spaces = (new Array(2 + (colLimits[i] - row[key].length))).join(" ");
				out += ` ${row[key]}${spaces}|`;
			}
			out += "\n";
		});
	} catch (RangeError) {
		console.error("ERROR:  Looks like you're using the wrong headers for this Policy Type!");
		invalid = true;
	}
	return (invalid) ? "ERROR:  Check the dev console!" : out;
}

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if(request.action === 'GET_TABLE') {
    var result = createPreviewValuesTable(request.data['header']);
    sendResponse({ output: result });
  }
});
