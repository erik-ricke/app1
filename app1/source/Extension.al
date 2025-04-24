pageextension 50100 CustomerCardExt extends "Customer Card"
{
    actions
    {
        addfirst(Processing)
        {
            action(CreateSalesOrder)
            {
                ApplicationArea = All;
                Caption = 'Create Sales Order';
                Image = Order;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesHeaderPage: Page "Sales Order";
                begin
                    // Neuen Verkaufsauftrag initialisieren
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    SalesHeader.Insert(true); // true für AutoIncrement
                    SalesHeader.Validate("Sell-to Customer No.", Rec."No.");
                    SalesHeader.Modify(true);

                    // Seite öffnen (optional)
                    PAGE.Run(PAGE::"Sales Order", SalesHeader);
                end;
            }
        }
    }
}
