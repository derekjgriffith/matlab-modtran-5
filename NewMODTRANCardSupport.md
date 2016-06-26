**How to add support for a new card in the MODTRAN wrapper**

# Introduction #
There are several steps required to add support for a new card, or new properties on an existing card.

## Add or Update Card and Property Descriptions ##
The card descriptions are a hidden property of the class. These need to be updated whenever support for a new card is added, or a card changes in any way.

## Update or Create the Card Read Method ##
Each card has a method to read that card from a .ltn or .tp5 file. The read method for the new card must be created, or updated to add new properties on the card.

## Update or Create the Card Write Method ##
Each card has a method to write the corresponding details to the tape 5 (.tp5) file. A new card requires a new method to write the card, or an existing method must be updated to cater for new properties on the card.

## Update the Class Constructor ##
The class constructor is called Mod5 and reads a case from a .ltn or .tp5 file. Conditional calls to the ReadCard methods generally neeed to be inserted for new cards.

## Update the Class Write Method ##
The Write method writes the tape 5 format file required as the main control input to MODTRAN. The control flow in the Write method will typically need similar changes to the constructor method.

## Update the Describe Method ##
The Describe method describes a MODTRAN card deck. The control flow in the Describe method will need similar changes to those required in the constructor and the Write methods.