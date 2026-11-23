# Courtyard assembly policy V1

26 October 2026. This is a plan for the current Carrier_V1 warning repair while preserving all component positions, rotations, pads, models and electrical nets. No source or candidate CAD is edited by this plan.

The input PCB SHA256 is `e4988e22f11b77c954724e793c8ef0b5435e44102366296310c13255204f69dd`. The root agent reports the user's newly saved/protected board has this same hash and all 92 poses match, so the recorded world screening applies to that saved checkpoint. Any later placement or package change requires fresh screening.

## Selected CAD profile

The selected profile key is **`compact_stated_package_0p10`** in Courtyard_Compact_Assembly_Plan_V1.json (source evidence retained in the dated review delivery). It uses one preselected **0.10 mm courtyard excess**, not an iterative attempt to shrink each warning away. It is informed by the Least-density courtyard excess described by the PCB Libraries author in [Courtyard Calculation, 1 June 2023](https://www.pcblibraries.com/forum/courtyard-calculation_topic3278.html). That primary author explicitly distinguishes the IPC-7351 Least/nominal/most excess values and the tool defaults.

This is a board-specific compact **assembly courtyard** profile. The existing pad patterns are preserved; they are not regenerated as IPC density-C solder-joint land patterns. The profile is not a claim that the board has passed a complete IPC land-pattern, assembly-process or fabrication qualification. Manufacturer assembly acceptance, rework access and process tolerances remain open.

The [KiCad Library Conventions F5.3](https://klc.kicad.org/footprint/f5/f5.3/) are retained as a comparison: they allow contoured courtyards, use 0.05 mm strokes / 0.01 mm grid, normally recommend 0.25 mm excess, and have larger defaults for crystals and connectors. They are library contribution conventions; this project explicitly selects a different compact assembly excess. Source User.15 rectangles and the earlier 0.25 mm / KLC-default screens are preserved in the companion reports rather than silently discarded.

## Construction and scope

For every affected footprint, the plan collects every native pad's bounding box, native Fab terminal rectangles, native Fab body-outline extent, and the package outline input identified below. It expands each primitive by 0.10 mm, rounds outward to a local 0.01 mm grid, and takes their convex hull. The result is one simple closed contour. This is conservative relative to the collected primitive union; it does not cut inward around neighboring components. The plan proves each input primitive is enclosed, all vertices are on-grid, each outline is simple, and no active/candidate geometry was changed.

Eleven missing courtyard instances are U3-U8, Y1 and FB1-FB4. Their local F.CrtYd contours are mirrored in local Y for the placed B.CrtYd instances; footprint translation/rotation is applied only for the independent world screen. The JSON provides both local forms and the resulting world coordinates. Root should splice local instance coordinates, not copy world positions back into a footprint.

J4 is the necessary twelfth courtyard: keeping its old 0.50 mm side envelope would still overlap FB2 under the single compact profile. J4's side/rear assembly envelope adopts the same 0.10 mm policy. Its **entire existing front/mating cap, local X=-4.97..+4.97 mm and Y=+2.33..+4.18 mm**, is retained inside the new conservative convex outline. The original footprint body, mounting/contact pads, holes and model remain unchanged. This is not an authorization to shrink the mating region.

## Package outline inputs and limitations

| References | Selected profile A input | Additional known limit / overlay |
|---|---|---|
| U3, FT232HQ | 8.00 x 8.00 mm BSC package reference plus native Fab/pads | FTDI v2.2 p51 Fig8.1 supplies BSC dimensions, not a separate numerical max-body/flash allowance. This remains a package-tolerance qualification limit. |
| U4-U7, SN74AXC1T45 DBV | **3.05 x 1.75 mm stated maximum body**, larger than the imported 3.0 x 1.5 mm Fab body | TI drawing 4214840/G, 08/2024 excludes mold flash/protrusions and permits up to 0.25 mm per side. Profile A explicitly excludes that separate flash allowance; profile B includes it. |
| U8, 93LC56B-E/MS | 3.00 x 3.00 mm BSC body reference plus native Fab/pads and drawn terminals | Microchip DS21794F p15 drawing C04-111B permits 0.15 mm/side flash. Profile A explicitly excludes that separate flash allowance; profile B includes it. BSC is not a claimed 3.10 mm max. |
| Y1, ABM8 family reference | **3.40 x 2.70 mm family outline max**, from 3.2 +/-0.20 by 2.5 +/-0.20 | Abracon Rev07-29-20 p2. Exact populated crystal MPN/load/height variant remains unselected; this is the datasheet linked by the native circuit, not a new part selection. |
| FB1/FB3/FB4, Laird MI0603J601R-10 | **1.75 x 0.95 mm maximum body** plus the larger native pad envelope | Laird Rev C sheet 1: length 1.60 +/-0.15, width 0.80 +/-0.15 mm. Existing land pattern and model are unchanged. |
| FB2, Murata BLM21PG221SN1D | **2.20 x 1.45 mm maximum body** plus the native pad envelope | Manufacturer product sheet p1: length 2.0 +/-0.2, width 1.25 +/-0.2 mm. Manufacturer-authored 2020-04-28 sheet was retrieved from a mirror; current official indexed rows agree but direct official fetch is blocked. |
| J4, GCT USB4110 | 8.94 x 7.35 mm native Fab reference plus all contact/mounting/locator pad bounds | Current native geometry is source-bound. The exact manufacturer maximum/tolerance stack was not independently resolved in this plan. Original front/mating reserve remains present. |

Primary package references: [TI SN74AXC1T45](https://www.ti.com/lit/ds/symlink/sn74axc1t45.pdf), [FTDI FT232H v2.2](https://ftdichip.cn/Support/Documents/DataSheets/ICs/DS_FT232H.pdf), [Microchip DS21794F](https://ww1.microchip.com/downloads/en/DeviceDoc/21794F.pdf), [Abracon ABM8](https://abracon.com/Resonators/abm8.pdf), [Laird MI0603](https://www.laird.com/sites/default/files/mi0603j601r-10-datasheet.pdf), [Murata official indexed product PDF](https://www.murata.com/en-eu/api/pdfdownloadapi?cate=cgsubChipFerriBead&partno=BLM21PG221SN1D), [manufacturer-authored Murata mirror](https://jm.pl/gfx-base/s_1/orgs/18/BLM21PG221SN1D.pdf), [GCT product reference](https://gct.co/connector/usb4110).

## Honest tolerance overlay

The preserved **`compact_known_flash_0p10`** profile includes all separately quantified flash allowances currently known: U4-U7 become 3.55 x 2.25 mm bounds, and U8 becomes 3.30 x 3.30 mm. It keeps the same 0.10 mm excess, J4 front reserve and all other inputs. It is named *known flash*, not *all worst-case manufacturing limits*, because FTDI/GCT and exact Y1 selection still have unresolved limits.

Profile A has **zero positive-area courtyard intersections** against the current same-side native cached courtyards after the twelve outlined courtyard replacements. Profile B has **three positive-area intersections**: U4/U5, U5/U7 and U6/U7. Each is about 0.150 mm2. The package bodies at the known extreme flash bounds remain about 0.150 mm apart, but two 0.10 mm courtyard excesses cannot fit into that gap. These are real tolerance/assembly qualification constraints. They must remain OPEN, not be hidden with exclusion flags, globally disabled checks, narrowed unrecorded envelopes or a claim of toleranced production fit.

No pads, copper clearance rules or component poses are modified by either overlay. The user's fixed placements are preserved; the selected green CAD envelope represents the stated package/reference profile, not the full known-flash envelope.

## Reference geometry gap checks

These are calculated gaps between source/Fab/pad bounding geometry at the saved poses, not measurements of a manufactured assembly. The source bodies/lands in these selected adjacency checks do not collide.

| Adjacent pair(s) | Reference/stated-profile gap |
|---|---:|
| U3 / R13 | 0.295 mm |
| U4-U7 / each adjacent bypass capacitor | 0.365 mm |
| U3 / C14 | 0.415 mm |
| FB2 / J4 | 0.450 mm |
| U8 / C22 | 0.490 mm |
| FB1 / FB4 | 0.505 mm |
| Y1 / C17 or C18 | 0.540 mm |
| Adjacent U4-U7 bodies, stated maximum package profile | 0.650 mm |
| Adjacent U4-U7 bodies, separately allowed flash included | 0.150 mm |

Native validation of this candidate reports zero violations, zero unconnected items and zero schematic-parity findings with all five formerly ignored categories enabled. This is a saved-CAD check under the stated/reference profile, not full-flash or manufacturing qualification. The dated warning-fix delivery retains the source drawings, exact polygons, both tolerance overlays and independent preservation audit.
