# This checkbox is used to display data if a Sales Line on the Document has a Qty Fulfilled
# that is less than the Qty on the Document, as long as there is more available Inventory
Feature: Printed Reports

    Background: 
        Given the user is printing a Sales Document Report

    Scenario: "Include Pick List Bins" is checked
        Given InventoryPickBins Data fields are on the report
        And a Sales Line is not completely fulfilled
        But there is enough inventory to completely fulfill the Sales Line
        When the report loads
        Then InventoryPickBins data is contained on the Report