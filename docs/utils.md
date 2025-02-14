### Check how much Mem is ags or any program taking
`ps aux | grep -i ags | awk '{sum+=$6} END {print sum/1024 " MB"}'`

### Font Family check
`fc-list : family | grep -i "<name>"`
