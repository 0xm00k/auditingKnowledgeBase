# Reentrancy

## Missed In:
- Beedle

## How I Missed It:
- Didn't trace external calls inside fallback function
- Ignored nested call in withdraw()

## How to Not Miss It:
- Check every external call
- Verify if state changes occur before external calls

## Checklist:
- [ ] Any external calls? (e.g., `.call`, `.transfer`, `.send`) — flag and trace
- [ ] State changed **after** external call? — red flag
- [ ] Use of reentrancy guards?