function visitLocalCarbon() {
  cy.visit('/illustrations/cases');
}

function createClient(first, middle, last, gender, bday) {
  cy.get("button[data-qa='CaseListNewClient']").click();
  cy.url().should('include', '/cases/person');
  cy.get("input[data-qa='clientFirstName']")
    .type(first)
    .should('have.value', first);
  cy.get("input[data-qa='clientMidName']")
    .type(middle)
    .should('have.value', middle);
  cy.get("input[data-qa='clientLastName']")
    .type(last)
    .should('have.value', last);
  cy.get("select[data-qa='gender']")
    .select(gender);
  if (bday !== "N/A") {
    cy.get("input[data-qa='birthdate']")
      .type(bday);
  }
  cy.get("button[data-qa='NewClientDone']")
    .click();
  cy.url().should('match', /\/illustrations\/case\/\d+/);
}

function removeClient() {
  cy.get("button[data-qa='ClientButton']")
    .click();
  cy.get("button[data-qa='NewClientRemove']")
    .click();
  cy.get("button[data-qa='RemoveModalOk']")
    .click();
}

function createProduct(type) {
  cy.get("button[data-qa='NewIllustrationButton']")
    .first().click();
  cy.get(`button[data-title='${type}']`)
    .click();
  cy.url().should('match', /\/illustrations\/case\/\d+\/policy\/\d+/);
  cy.get("input[data-qa='selectedPolicyText']")
    .should('have.value', type);
}

describe('Replica of E2E/acl/aclPremiumLimit.feature', () => {
  it('Creates a new client', () => {
    visitLocalCarbon();
    createClient("A", "B", "C", "Female", "N/A");
  });
  it('Creates a new ACL Product', () => {
    createProduct('Adjustable CompLife');
  });
  it('Updates Insurable Age to "5"', () => {
    cy.get("input[data-qa='InsuredAge']").clear().type('5');
  });
  it('Toggles Companion Policy to "true"', () => {
    cy.get("input[data-qa='LifePolicyCompanion']").check();
  });
  it('Changes Specify option to "Death Benefit & Premium"', () => {
    cy.get("select[data-qa='LifePolicyAclTibMode']")
      .select("Death Benefit & Premium");
  });
  it('Changes Total Death Benefit to "397k"', () => {
    cy.get("input[data-qa='LifePolicyTotalDeathBenefit']")
      .clear().type('397k');
  });
  it('Changes Total Premium to "3k"', () => {
    cy.get("input[data-qa='LifePolicyPremium']")
      .clear().type('3k');
  });
  it('Validates an error message appeared', () => {
    cy.get("div[data-qa='MessagesTab']").click();
    cy.get("div[data-qa='SidePanelMessageBody']")
      .should('contain', 'Total Premium is only $1,772.50 based on the Total Death Benefit.');
  });
  it('Changes Total Premium to "1772.50"', () => {
    cy.get("input[data-qa='LifePolicyPremium']")
      .clear().type('1772.50');
  });
  it('Validates Quick Values', () => {
    // TODO: QUICK VALUES
  });
  it('Selects "Short Term" Policy Dating', () => {
    cy.get("div[data-qa='PolicyDatingPanel']").click();
    cy.get("input[data-qa='ShortTerm']").check();
  });
  it('Validates an error message appeared', () => {
    cy.get("div[data-qa='MessagesTab']").click();
    cy.get("div[data-qa='SidePanelMessageBody']")
      .should('contain', 'cannot be selected without a birthdate.');
  });
  it('Selects "No Special Dating" Policy Dating', () => {
    cy.get("input[data-qa='NoSpecialDating']").check();
  });
  it('Validates Quick Values', () => {
    // TODO: QUICK VALUES
  });
  it('Opens the Page Selection Output Options tab', () => {
    cy.get("button[data-qa='PageSelectionTab']").click()
  });
  it('Toggles NAIC Basic to "true"', () => {
    cy.get("input[data-qa='IncludeNAICBasicIllustration']").check();
  });
  it('Toggles Sales Illustration to "false"', () => {
    cy.get("input[data-qa='IncludeSupplementalIllustration']").uncheck();
  });
  it('Views the Illustration with "7" pages', () => {
    cy.get("button[data-qa='ViewIllustration']").click();
    cy.get("span[data-qa='totalNumOfOutputPages']").should('contain', '7');
    cy.get("button[class='c-illusout-btn']").click();
  });
  // it('Saves the illustration', () => {
  //   cy.get("button[data-qa='outputSaveButton']").click();
  // });
  it('Deletes the client', () => {
    cy.get("a[data-qa='CaseSummaryBackArrow']")
      .click();
    removeClient();
  });
  it('Navigates back to case summary', () => {
    cy.get("a[data-qa='CaseDetailsBackArrow']")
      .click();
  });
});
