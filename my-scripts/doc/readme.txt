1) create a new repo on github

git clone git@github.com:RobertBerger/meta-ampliphy.git

2) add my-scripts dir

cd meta-ampliphy

echo "# meta-phytec fork" >> README.md

git init

git add .

git commit -m "first commit"

git remote add origin git@github.com:RobertBerger/meta-ampliphy.git

git push -u origin master

3) use my repo

mv meta-ampliphy meta-ampliphy.ori
git clone git@github.com:RobertBerger/meta-ampliphy.git

4) add upstream

cd meta-ampliphy

git remote add official-upstream https://github.com/phytec/meta-ampliphy

$ git fetch official-upstream

git fetch official-upstream
warning: no common commits
remote: Enumerating objects: 21377, done.
remote: Counting objects: 100% (4424/4424), done.
remote: Compressing objects: 100% (1506/1506), done.
remote: Total 21377 (delta 3237), reused 3942 (delta 2830), pack-reused 16953 (from 1)
Receiving objects: 100% (21377/21377), 2.75 MiB | 14.30 MiB/s, done.
Resolving deltas: 100% (14481/14481), done.
From https://github.com/phytec/meta-ampliphy
 * [new branch]      gatesgarth                        -> official-upstream/gatesgarth
 * [new branch]      hardknott                         -> official-upstream/hardknott
 * [new branch]      honister                          -> official-upstream/honister
 * [new branch]      kirkstone                         -> official-upstream/kirkstone
 * [new branch]      langdale                          -> official-upstream/langdale
 * [new branch]      master                            -> official-upstream/master
 * [new branch]      mickledore                        -> official-upstream/mickledore
 * [new branch]      scarthgap                         -> official-upstream/scarthgap
 * [new branch]      walnascar                         -> official-upstream/walnascar
 * [new branch]      wrynose                           -> official-upstream/wrynose
 * [new tag]         BSP-Yocto-Ampliphy-AM57x-PD26.1.0 -> BSP-Yocto-Ampliphy-AM57x-PD26.1.0
 * [new tag]         BSP-Yocto-Ampliphy-i.MX6-PD25.1.1 -> BSP-Yocto-Ampliphy-i.MX6-PD25.1.1
 * [new tag]         BSP-Yocto-NXP-i.MX8MP-PD22.1.2    -> BSP-Yocto-NXP-i.MX8MP-PD22.1.2
 * [new tag]           1.7.0-phy1                                -> 1.7.0-phy1
 * [new tag]           1.7.0-phy2                                -> 1.7.0-phy2
 * [new tag]           1.7.2-phy1                                -> 1.7.2-phy1
 * [new tag]           1.7.2-phy2                                -> 1.7.2-phy2
 * [new tag]           1.7.2-phy3                                -> 1.7.2-phy3
 * [new tag]           1.8.1-phy1                                -> 1.8.1-phy1
 * [new tag]           1.8.1-phy2                                -> 1.8.1-phy2
 * [new tag]           1.8.1-phy3                                -> 1.8.1-phy3
 * [new tag]           1.8.1-phy4                                -> 1.8.1-phy4
 * [new tag]           2.0.1-phy1                                -> 2.0.1-phy1
 * [new tag]           2.0.1-phy2                                -> 2.0.1-phy2
 * [new tag]           2.0.1-phy3                                -> 2.0.1-phy3
 * [new tag]           2.1.1-phy1                                -> 2.1.1-phy1
 * [new tag]           2.1.1-phy2                                -> 2.1.1-phy2
 * [new tag]           3.3.1-phy1                                -> 3.3.1-phy1
 * [new tag]           3.3.1-phy2                                -> 3.3.1-phy2
 * [new tag]           3.3.1-phy3                                -> 3.3.1-phy3
 * [new tag]           3.3.2-phy1                                -> 3.3.2-phy1
 * [new tag]           3.3.3-phy1                                -> 3.3.3-phy1
 * [new tag]           3.3.3-phy2                                -> 3.3.3-phy2
 * [new tag]           3.3.3-phy3                                -> 3.3.3-phy3
 * [new tag]           3.3.4-phy1                                -> 3.3.4-phy1
 * [new tag]           3.3.4-phy2                                -> 3.3.4-phy2
 * [new tag]           BSP-Yocto-Ampliphy-AM335x-PD23.1.0        -> BSP-Yocto-Ampliphy-AM335x-PD23.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM57x-PD24.1.0         -> BSP-Yocto-Ampliphy-AM57x-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD23.1.0        -> BSP-Yocto-Ampliphy-AM62Ax-PD23.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD23.1.1        -> BSP-Yocto-Ampliphy-AM62Ax-PD23.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD24.1.0        -> BSP-Yocto-Ampliphy-AM62Ax-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD24.1.1        -> BSP-Yocto-Ampliphy-AM62Ax-PD24.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD24.1.2        -> BSP-Yocto-Ampliphy-AM62Ax-PD24.1.2
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD25.1.0        -> BSP-Yocto-Ampliphy-AM62Ax-PD25.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62Ax-PD25.1.1        -> BSP-Yocto-Ampliphy-AM62Ax-PD25.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM62Lx-ALPHA1          -> BSP-Yocto-Ampliphy-AM62Lx-ALPHA1
 * [new tag]           BSP-Yocto-Ampliphy-AM62Lx-ALPHA2          -> BSP-Yocto-Ampliphy-AM62Lx-ALPHA2
 * [new tag]           BSP-Yocto-Ampliphy-AM62Px-ALPHA1          -> BSP-Yocto-Ampliphy-AM62Px-ALPHA1
 * [new tag]           BSP-Yocto-Ampliphy-AM62Px-PD26.1.0        -> BSP-Yocto-Ampliphy-AM62Px-PD26.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD23.2.0         -> BSP-Yocto-Ampliphy-AM62x-PD23.2.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD23.2.1         -> BSP-Yocto-Ampliphy-AM62x-PD23.2.1
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD24.1.0         -> BSP-Yocto-Ampliphy-AM62x-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD24.1.1         -> BSP-Yocto-Ampliphy-AM62x-PD24.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD24.1.2         -> BSP-Yocto-Ampliphy-AM62x-PD24.1.2
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD25.1.0         -> BSP-Yocto-Ampliphy-AM62x-PD25.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM62x-PD25.1.1         -> BSP-Yocto-Ampliphy-AM62x-PD25.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD23.2.0         -> BSP-Yocto-Ampliphy-AM64x-PD23.2.0
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD23.2.1         -> BSP-Yocto-Ampliphy-AM64x-PD23.2.1
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD24.1.0         -> BSP-Yocto-Ampliphy-AM64x-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD24.1.1         -> BSP-Yocto-Ampliphy-AM64x-PD24.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD25.1.0         -> BSP-Yocto-Ampliphy-AM64x-PD25.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD25.2.0         -> BSP-Yocto-Ampliphy-AM64x-PD25.2.0
 * [new tag]           BSP-Yocto-Ampliphy-AM64x-PD25.2.1         -> BSP-Yocto-Ampliphy-AM64x-PD25.2.1
 * [new tag]           BSP-Yocto-Ampliphy-AM67x-ALPHA1           -> BSP-Yocto-Ampliphy-AM67x-ALPHA1
 * [new tag]           BSP-Yocto-Ampliphy-AM67x-PD25.1.0         -> BSP-Yocto-Ampliphy-AM67x-PD25.1.0
 * [new tag]           BSP-Yocto-Ampliphy-AM67x-PD25.1.1         -> BSP-Yocto-Ampliphy-AM67x-PD25.1.1
 * [new tag]           BSP-Yocto-Ampliphy-AM68x-ALPHA2           -> BSP-Yocto-Ampliphy-AM68x-ALPHA2
 * [new tag]           BSP-Yocto-Ampliphy-AM68x-ALPHA3           -> BSP-Yocto-Ampliphy-AM68x-ALPHA3
 * [new tag]           BSP-Yocto-Ampliphy-AM68x-PD24.1.0         -> BSP-Yocto-Ampliphy-AM68x-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6-PD21.1.1         -> BSP-Yocto-Ampliphy-i.MX6-PD21.1.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6-PD22.1.0         -> BSP-Yocto-Ampliphy-i.MX6-PD22.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6-PD22.1.1         -> BSP-Yocto-Ampliphy-i.MX6-PD22.1.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6-PD25.1.0         -> BSP-Yocto-Ampliphy-i.MX6-PD25.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD21.2.0       -> BSP-Yocto-Ampliphy-i.MX6UL-PD21.2.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD21.2.1       -> BSP-Yocto-Ampliphy-i.MX6UL-PD21.2.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD22.1.0       -> BSP-Yocto-Ampliphy-i.MX6UL-PD22.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD22.1.1       -> BSP-Yocto-Ampliphy-i.MX6UL-PD22.1.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.0       -> BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.1       -> BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.2       -> BSP-Yocto-Ampliphy-i.MX6UL-PD24.1.2
 * [new tag]           BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.0       -> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.0
 * [new tag]           BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.1       -> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.1
 * [new tag]           BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2       -> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2
 * [new tag]           BSP-Yocto-CelebrityFaceMatch-i.MX8MP-v0.6 -> BSP-Yocto-CelebrityFaceMatch-i.MX8MP-v0.6
 * [new tag]           BSP-Yocto-CelebrityFaceMatch-i.MX8MP-v0.7 -> BSP-Yocto-CelebrityFaceMatch-i.MX8MP-v0.7
 * [new tag]           BSP-Yocto-Connagtive-i.MX8MM-v2.0         -> BSP-Yocto-Connagtive-i.MX8MM-v2.0
 * [new tag]           BSP-Yocto-EdgeAI-AM68x-v0.1               -> BSP-Yocto-EdgeAI-AM68x-v0.1
 * [new tag]           BSP-Yocto-EdgeAI-AM68x-v0.2               -> BSP-Yocto-EdgeAI-AM68x-v0.2
 * [new tag]           BSP-Yocto-ImagingKit-VC-i.MX8MP-v0.1      -> BSP-Yocto-ImagingKit-VC-i.MX8MP-v0.1
 * [new tag]           BSP-Yocto-IndComms-IBV-AM64x-v0.1         -> BSP-Yocto-IndComms-IBV-AM64x-v0.1
 * [new tag]           BSP-Yocto-KivyDemo-i.MX8MP-v0.1           -> BSP-Yocto-KivyDemo-i.MX8MP-v0.1
 * [new tag]           BSP-Yocto-LVGLDemo-i.MX8MP-v0.1           -> BSP-Yocto-LVGLDemo-i.MX8MP-v0.1
 * [new tag]           BSP-Yocto-LVGLDemo-i.MX8MP-v0.2           -> BSP-Yocto-LVGLDemo-i.MX8MP-v0.2
 * [new tag]           BSP-Yocto-NXP-i.MX7-PD23.1.0              -> BSP-Yocto-NXP-i.MX7-PD23.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX7-PD23.1.1              -> BSP-Yocto-NXP-i.MX7-PD23.1.1
 * [new tag]           BSP-Yocto-NXP-i.MX7-PD23.1.2              -> BSP-Yocto-NXP-i.MX7-PD23.1.2
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD22.1-rc1          -> BSP-Yocto-NXP-i.MX8MM-PD22.1-rc1
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD22.1.0            -> BSP-Yocto-NXP-i.MX8MM-PD22.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD22.1.1            -> BSP-Yocto-NXP-i.MX8MM-PD22.1.1
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD23.1.0            -> BSP-Yocto-NXP-i.MX8MM-PD23.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD25.1.0            -> BSP-Yocto-NXP-i.MX8MM-PD25.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MM-PD25.1.1            -> BSP-Yocto-NXP-i.MX8MM-PD25.1.1
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-FPSC-ALPHA1         -> BSP-Yocto-NXP-i.MX8MP-FPSC-ALPHA1
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-PD22.1.0            -> BSP-Yocto-NXP-i.MX8MP-PD22.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-PD22.1.1            -> BSP-Yocto-NXP-i.MX8MP-PD22.1.1
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-PD23.1.0            -> BSP-Yocto-NXP-i.MX8MP-PD23.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-PD24.1.0            -> BSP-Yocto-NXP-i.MX8MP-PD24.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX8MP-PD26.1.0            -> BSP-Yocto-NXP-i.MX8MP-PD26.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX91-PD24.2.1             -> BSP-Yocto-NXP-i.MX91-PD24.2.1
 * [new tag]           BSP-Yocto-NXP-i.MX91-PD24.2.2             -> BSP-Yocto-NXP-i.MX91-PD24.2.2
 * [new tag]           BSP-Yocto-NXP-i.MX91-PD26.1.0             -> BSP-Yocto-NXP-i.MX91-PD26.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX93-ALPHA1               -> BSP-Yocto-NXP-i.MX93-ALPHA1
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD24.1.0             -> BSP-Yocto-NXP-i.MX93-PD24.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD24.1.1             -> BSP-Yocto-NXP-i.MX93-PD24.1.1
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD24.2.0             -> BSP-Yocto-NXP-i.MX93-PD24.2.0
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD24.2.1             -> BSP-Yocto-NXP-i.MX93-PD24.2.1
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD24.2.2             -> BSP-Yocto-NXP-i.MX93-PD24.2.2
 * [new tag]           BSP-Yocto-NXP-i.MX93-PD26.1.0             -> BSP-Yocto-NXP-i.MX93-PD26.1.0
 * [new tag]           BSP-Yocto-NXP-i.MX95-ALPHA1               -> BSP-Yocto-NXP-i.MX95-ALPHA1
 * [new tag]           BSP-Yocto-NXP-i.MX95-ALPHA2               -> BSP-Yocto-NXP-i.MX95-ALPHA2
 * [new tag]           BSP-Yocto-SlintDemo-i.MX8MP-v0.1          -> BSP-Yocto-SlintDemo-i.MX8MP-v0.1
 * [new tag]           BSP-Yocto-SlintDemo-i.MX8MP-v0.2          -> BSP-Yocto-SlintDemo-i.MX8MP-v0.2
 * [new tag]           BSP-Yocto-phyCONTROL-Nova-i.MX8MP-v0.1    -> BSP-Yocto-phyCONTROL-Nova-i.MX8MP-v0.1

...

$ git branch -a

* master
  remotes/official-upstream/gatesgarth
  remotes/official-upstream/hardknott
  remotes/official-upstream/honister
  remotes/official-upstream/kirkstone
  remotes/official-upstream/langdale
  remotes/official-upstream/master
  remotes/official-upstream/mickledore
  remotes/official-upstream/scarthgap
  remotes/official-upstream/walnascar
  remotes/official-upstream/wrynose
  remotes/origin/HEAD -> origin/master
  remotes/origin/master


$ git tag -l

1.7.0-phy1
1.7.0-phy2
1.7.2-phy1
1.7.2-phy2
1.7.2-phy3
1.8.1-phy1
1.8.1-phy2
1.8.1-phy3
1.8.1-phy4
2.0.1-phy1
2.0.1-phy2
2.0.1-phy3
2.1.1-phy1
2.1.1-phy2
3.3.1-phy1
3.3.1-phy2
3.3.1-phy3
3.3.2-phy1
3.3.3-phy1
3.3.3-phy2
3.3.3-phy3
3.3.4-phy1
3.3.4-phy2
BSP-Yocto-Ampliphy-AM335x-PD23.1.0
BSP-Yocto-Ampliphy-AM57x-PD24.1.0
BSP-Yocto-Ampliphy-AM57x-PD26.1.0
BSP-Yocto-Ampliphy-AM62Ax-PD23.1.0
BSP-Yocto-Ampliphy-AM62Ax-PD23.1.1
BSP-Yocto-Ampliphy-AM62Ax-PD24.1.0
BSP-Yocto-Ampliphy-AM62Ax-PD24.1.1
BSP-Yocto-Ampliphy-AM62Ax-PD24.1.2
BSP-Yocto-Ampliphy-AM62Ax-PD25.1.0
BSP-Yocto-Ampliphy-AM62Ax-PD25.1.1
BSP-Yocto-Ampliphy-AM62Lx-ALPHA1
BSP-Yocto-Ampliphy-AM62Lx-ALPHA2
BSP-Yocto-Ampliphy-AM62Px-ALPHA1
BSP-Yocto-Ampliphy-AM62Px-PD26.1.0
BSP-Yocto-Ampliphy-AM62x-PD23.2.0
BSP-Yocto-Ampliphy-AM62x-PD23.2.1
BSP-Yocto-Ampliphy-AM62x-PD24.1.0
BSP-Yocto-Ampliphy-AM62x-PD24.1.1
BSP-Yocto-Ampliphy-AM62x-PD24.1.2
BSP-Yocto-Ampliphy-AM62x-PD25.1.0
BSP-Yocto-Ampliphy-AM62x-PD25.1.1
BSP-Yocto-Ampliphy-AM64x-PD23.2.0
BSP-Yocto-Ampliphy-AM64x-PD23.2.1
...

5) use specific upstream branch and make our own branch

git co remotes/origin/master

5.1) we want commit: 633e8ed591559b45eadd5f799f2ff7234c713445

git co 633e8ed591559b45eadd5f799f2ff7234c713445

git branch 2026-08-11-training

git co 2026-08-11-training

# that's the unmodified meta-ampliphy
git tag meta-ampliphy-633e8ed591559b45eadd5f799f2ff7234c713445

5.2) staging/meld merge in the modifications

5.3) push upstream

git co master
cd my-scripts
./push-all-to-github.sh




#5) use specific upstream branch/commit and make own branch
#
#syntax: git fetch url-to-repo branchname:refs/remotes/origin/branchname
#
#$ git fetch git://github.com/STMicroelectronics/meta-st-stm32mp dunfell:refs/remotes/origin/dunfell
#
#From git://github.com/Freescale/meta-freescale
# * [new branch]        dunfell    -> origin/dunfell
#

#6) Update from upstream:
#git co master
#>> git remote -v
#
#official-upstream       git://github.com/Freescale/meta-freescale (fetch)
#official-upstream       git://github.com/Freescale/meta-freescale (push)
#origin  git@github.com:RobertBerger/meta-freescale.git (fetch)
#origin  git@github.com:RobertBerger/meta-freescale.git (push)
#
#>> git fetch official-upstream
#remote: Counting objects: 4043, done.
#remote: Compressing objects: 100% (1273/1273), done.
#remote: Total 4043 (delta 3130), reused 3632 (delta 2727)
#Receiving objects: 100% (4043/4043), 721.50 KiB | 402.00 KiB/s, done.
#Resolving deltas: 100% (3130/3130), completed with 502 local objects.
#From git://git://github.com/Freescale/meta-freescale
#   62591d9..e758547  master     -> official-upstream/master
# + 2942327...a382678 master-next -> official-upstream/master-next  (forced update)
#   a3fa5ce..6a1f33c  morty      -> official-upstream/morty
#---
#

6) hack the branch and update

6.1) hack it

6.2) add/commit

6.3) What was changed?

$ git diff 2021-06-09-3ba7567532bcda55d9d73deff80a350877b68d07-pd21.1.0-stm-dunfell --stat
 conf/layer.conf                                                           | 2 +-
 recipes-bsp/u-boot/{u-boot_2020.01.bbappend => u-boot_2020.01.bbbbappend} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

7) push upstream:
git co master
cd my-scripts
./push-all-to-github.sh

#8) apply patches
#
#cd meta-virtualization
#
#git co 2019-09-09-warrior-2.7+
#
#stg init
#
#stg series
#
#stg import --mail ../meta-virtualization-patches/2019-09-09-warrior-2.7+/0001-use-systemd-as-cgroup-manager-for-docker-While-it-s-.patch
#
#import all patches
#
#...
#
#stg series
#
#stg commit --all
#
#git log
#
#git co master
#
9) push to my upstream

my-scripts/push-all-to-github.sh

