### File format for csv upload (DotPlot feature input)
___

Data entry for a `DotPlot` should be done by uploaded a __single-column csv file__ containing the genes/features of interest. The file may or may not contain a header (default is file contains header. This can be modified in the `Indicate if your file has a header` checkbox).

Gene/feature names should follow standard convention by the gene search option available for `Violin` and `FeaturePlot`. To summarize the assumptions:

* By default gene names are converted to standard zebrafish nomenclature.
* To bypass default behavior, you may enclose genes/feature inside doublet quotes (`""` ; e.g.: `"si:ch211-51e12.7"`).

Further:

* A sensible maximum number of genes/features default has been set by the app to avoid generating `DotPlot` which require extreme width. __The current maximum number of genes/features is: 60__. Upon request, this threshold can be changed in the future. __NOTE__: if you use the app with a small screen device, we recommend to look at the `DotPlot` once you download the image with proper dimensions.
* A properly formatted table example is:

<!-- Tip: use VS code CSV to Markdown Table converter for quick conversion -->

<style>
.basic-styling td,
.basic-styling th {
  border: 1px solid #999;
  padding: 0.5rem;
  text-align: center;
}
.basic-styling tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>

<div class="ox-hugo-table basic-styling">
<div></div>
<div class="table-caption">
  <span class="table-number"></span>
</div>

|dotplot_data|
|---|
|her4.2|
|neurod4|
|neurod1|
|tubb5|
|vim|
|eomesa|
|bhlhe22|
|emx1|
|emx2|
|emx3|
|tbr1b|
|zbtb20|
|sox5|
|zbtb18|
|prox1a|
|prox1b|
|rprml|
|pyya|
|rprma|
|prkcda|
|cbln1|
|pdyn|
|fezf1|
|c1ql3b.1|
|efna1b|
|pvalb7|
|lhx9|
|lhx1a|
|"si:ch211-51e12.7"|

</div>
