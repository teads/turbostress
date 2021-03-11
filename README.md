This tool generates load and outputs computer power metrics for this load.  
It's meant to run on a bare metal Linux host.  

# Usage
Use `--help` flag to get help on usage
```
This tool generates load and outputs computer power metrics for this load.
It requires adequate privileges(CAP_SYS_RAWIO, or simply run as `sudo`) to read the metrics.

It combines CPU load generation using `stress-ng` and power metrics measurement using `turbostat`.
For each load step from 0 to 100, a CPU load corresponding is started and multiple measures of power metrics are taken.
The value of each metric for each step is the mean of the multiple measurements. 
More advanced tests are launched after CPU one (ipsec, vm, maximize) to stress with different patterns.

Progression messages are written to STDERR while results are written to STDOUT.
The two can be separated to build a CSV result file while displaying the progression on the console, ex: turbostress | tee results.csv

Usage:
   [flags]

Flags:
      --cpu-info                                 output CPU info before results (default true)
      --duration-between-measures duration       the duration to wait between two measures (default 1s)
  -h, --help                                     help for this command
      --ipsec                                    launch ipsec test to trigger advanced CPU instructions. See stress-ng ipsec-mb flag (default true)
      --load-duration-before-measures duration   duration to wait between load start and measures (default 5s)
      --load-step int                            increment the stress load from 0 to 100 with this value (default 25)
      --maximize                                 launch a stress maximizing stressors values. See stress-ng maximize flag (default true)
      --method string                            the method to use to generate the load. See stress-ng cpu-method flag (default "all")
      --metrics strings                          turbostat columns to read (default [PkgWatt,RAMWatt,PkgTmp])
      --repeat int                               measures are repeated with this value and the measure is the mean of all repetitions (default 10)
      --threads int                              number of threads to use for the load (default to the number of threads on the system)
      --vm                                       launch VM test. See stress-ng vm flag (default true)
```
## Without Docker
### Requirements
- `stress-ng` command
- `turbostat` command
- `golang 1.15`

`go run cmd/main.go`

## With Docker
```
docker build -t turbostress .
docker run -it --privileged turbostress
```
