
## Clairvoyante demo on DNAnexus
The repo contains code for setting up running 
[Clairvoyante]( https://www.biorxiv.org/content/early/2018/04/28/310458) 
on DNAnexus platform.  While it is designed to help deploy workflows 
and applets on DNAnexus platform, the configuration could be also useful 
for people who like to try Clairvoyante on their own computer.

If you have an DNAnexus account and familar with dx-toolkit,
you can login with `dx login` and select the public project "clairvoyante_dnanexus_demo" by

```
dx select clairvoyante_dnanexus_demo
```
or
```
dx select project-FG1YJ6Q08GQ1bPV084096XZX
```

You can see the content of the project by
```
$ dx ls
BGI_SEQ_NA12878_DATA/
BGI_SEQ_NA12878_training_results/
Illumina_HG001_training_results/
ONT_HG001_training_results/
PacBio_HG001_training_results/
applets/
cv_data/
data_from_the_preprint/
_clairvoyante_jupyter_demo
cv_variant_call
gpu_asset
notebook_gpu_asset
```

## Clone project
You can create a new project and clone the data inside `clairvoyante_dnanexus_demo`
to test it out. For example, to clone the project to a new project called `cv_test`,
you can do 

```
dx new project cv_test
dx cp clairvoyante_dnanexus_demo:/ cv_test:/
```

## Useful job scripts for going through building training dataset to calling variants
In the `job_scripts` directory, there are some 
pre-define job submission scripts that you can try out.
For example, to train a model with Illumina's NA12878 
data:

1. To generate training data

```
get_illumina_train_data.sh
```

2. Wait for the job to finsh. it takes about 3.5 hours.
After the data is prepared, we can run train the model: 

```
illumina_training.sh
```

The result will be in `Illumina_HG001_training_results`.
Check the `model_training.log` file to find the best validation
loss batch number from line like
```
Best validation loss at batch: 57
```

3. To call variants
Edit the `MODLE_PREFIX` environment variable
in the `get_illumina_variant_calls.sh` to use
the model from the specific bath. For example

```
MODLE_PREFIX=cv_model-000057
```

Then you can run `get_illumina_variant_calls.sh` to 
generate variant calls for HG002.

You can take a look at those script and modify for other
data.


```
get_illumina_variant_calls.sh
```

