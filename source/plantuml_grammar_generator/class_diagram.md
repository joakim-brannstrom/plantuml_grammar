PlantUML_ClassDiagram:
    UML             <- blank* "@startuml" eol Content* "@enduml" (blank* / eoi)

    Content         <   / Class
                        / Comment
                        / Inherit

    Class           <- "class" space+ ClassName blank* ClassBody?
    ClassName       <- identifier
    ClassBody       <  '{' (Class / ~(ClassContent*))* '}'
    ClassContent    <- !Class !'}' .

    Inherit         <  InheritRight / InheritLeft
    InheritRight    <  RelateIdFrom :('-'+ "|>") RelateIdTo
    InheritLeft     <  RelateIdTo :("<|" '-'+) RelateIdFrom

    RelateIdFrom    <- ClassName
    RelateIdTo      <- ClassName

    Comment         <- space* :'\'' ~((!eol .)*) :eol
