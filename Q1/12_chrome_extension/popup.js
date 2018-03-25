let submit = document.getElementById('submit');
let msg = document.getElementById('msg');
let outInput = document.getElementById('output');
let headElem = document.getElementById('header');

document.addEventListener('DOMContentLoaded', function() {
  submit.addEventListener('click', function() {
    var headValue = headElem.options[headElem.selectedIndex].value;
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      chrome.tabs.sendMessage(tabs[0].id, { action: 'GET_TABLE', data: { header: headValue } }, (resp) => {
        if (chrome.runtime.lastError) {
          outInput.value = "CHROME ERROR: " + chrome.runtime.lastError;
        } else {
          outInput.value = resp.output;
          outInput.focus();
          outInput.select();
          document.execCommand('copy');
          msg.innerHTML = "Table copied to clipboard!";
        }
      });
    });
  });
});
