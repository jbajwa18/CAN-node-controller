package can_package;

    parameter int CAN_ID_WIDTH = 11; 
    parameter int CAN_DATA_WIDTH = 8;
    parameter int CAN_CRC_WIDTH = 15; 

  typedef struct packed {
    logic [CAN_ID_WIDTH-1:0] id; // CAN identifier
    logic [CAN_DATA_WIDTH-1:0] data; // CAN data field
    logic rtr; // Remote Transmission Request bit
  } can_frame_t;

  typedef enum logic [2:0] { 
    TX_IDLE,
    TX_SOF,
    TX_ID,
    TX_CTRL,
    TX_DATA,
    TX_EOF
 } tx_state_t;

endpackage
