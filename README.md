# Georges CPAP
Plastic CPAP system with no moving parts.

# [Current Documentation](https://helpfulengineering.github.io/project-georges-cpap/)
Files in this repository are mainly for archival purposes + documentation. Source files are available [here](https://cad.onshape.com/documents/fcc843822e3f2cb218bbe91c/w/738c68d83bd9079113df055c/e/e5dcf7b0527b1f57e8a51f64?configuration=barb_id%3D0.003%2Bmeter%3Bchamber_width%3D0.003%2Bmeter%3Begress%3D4.0E-4%2Bmeter%3Bpatient_channel_diameter%3D0.005%2Bmeter%3Btext_depth%3D3.0E-4%2Bmeter%3Bwall_thickness%3D0.002%2Bmeter)

> #### Lowest O2 consumption rate of any CPAP system
> * Only 15-30L/min flow rate for 3.5-10cmH2O
>
> #### Doesn't require a flow generator
> * Eliminates investment in capital equipment and repair
> * Only needs an O2 source and a flowmeter
>
> #### Completely open airway
> * Eliminates re-breathing
> * Reduces risk of barotrauma
> * Decreases the work of breathing
> * Accomodates patient's high peak inspiratory flow demand
> * Allows use of suction catheter or bronchoscope without loss of CPAP
>
> #### Depends entirely on the O2 flow rate
> * Easily adjusts to patient's need (2.5-20cmH2O) simply by titrating O2 flow
> * PEEP adjustable by changing flow rate, without needing an additional valve
> 
> #### Complete, portable, single use system
> * CPAP set up in less than 2 minutes
> * Weighs only 10 grams and is 2" long
> * Permits CPAP without interruption during transport


## :vertical_traffic_light: [Project status](https://github.com/0x2b3bfa0/project-georges-cpap/projects/1)
*Note: actually being tracked through [GitHub Projects](https://github.com/0x2b3bfa0/project-georges-cpap/projects/1)*; follow the link to get a better view of the project status.
* [x] **Design**
* [x] **Prototyping**
* [ ] [**Calibration**](https://github.com/0x2b3bfa0/project-georges-cpap/issues/1)

## :gear: Manufacturing

### Mask Body
* Machine: Ender3 Pro
* Nozzle size: 0.4 mm
* Layer height: 0.28 mm
* Support: only for the protruding tubes.
* Notes for the mask: use variable layer height to print the valve section at 0.15 mm, and the rest at 0.4 mm for speed.

### Valve
* Machine: Anycubic Photon S
* Exposure: 3s
* Resin: basic

### Notes

* We're using the Montana Mask as the basis, but @aleksclark is terrible at freecad, so if you have to tweak the mask parameters, you'll need to trim off the excess of the strap anchors using the defeaturing tool
* It should be possible to add a biofilter to this design, see above for why it's not done yet


<!--
## Inspiration
After seeing that most of the recently designed ventilators were BVM-based and faced many manufacturing challenges that diminished their scalability, I've started to search better alternatives comprising non-invasive continuous ventilation, which [seemed to be a good idea](https://www.who.int/docs/default-source/coronaviruse/clinical-management-of-novel-cov.pdf). Fortunately, I found that some Spanish hospitals were using [a compact, commercial and medically-tested CPAP device](https://www.vygon.com/catalog/vygon-boussignac-cpap_572_00557013) that was really successful for the treatment of patients with mild/medium respiratory symptoms and didn't rely on electricity.

Though the working mechanism of this device was initially [patented](https://patents.google.com/patent/EP0978291B1/en) by its inventor (Georges Boussignac), the patents expired a year ago and everybody was free of replicating it, so the next obvious step was creating an open-source hardware alternative that could be readily mass-manufactured in this emergency situation.

## What it does
This device, consists only of a cleverly designed plastic piece that, when connected to a pressurized oxygen (or medical air) input, is able to deliver a continuous air flow to the patient without obstructing the airways. The *virtual valve*, formed by a radial laminar flow, allows the patients' lungs to keep a (selectable) minimum pressure as if the circuit had attached a mechanical PEEP valve, but allowing the patient to breathe freely in case of failure.

## What it doesn't do
This device doesn't filter the expiration air, but it has standard connections for medical-grade respiratory filters or, optionally, for 3M particulate filters (as last resort).

## Advantages
> #### Lowest O2 consumption rate of any CPAP system
> * Only 15-30L/min flow rate for 3.5-10cmH2O
>
> #### Doesn't require a flow generator
> * Eliminates investment in capital equipment and repair
> * Only needs an O2 source and a flowmeter
>
> #### Completely open airway
> * Eliminates re-breathing
> * Reduces risk of barotrauma
> * Decreases the work of breathing
> * Accomodates patient's high peak inspiratory flow demand
> * Allows use of suction catheter or bronchoscope without loss of CPAP
>
> #### Depends entirely on the O2 flow rate
> * Easily adjusts to patient's need (2.5-20cmH2O) simply by titrating O2 flow
> * PEEP adjustable by changing flow rate, without needing an additional valve
> 
> #### Complete, portable, single use system
> * CPAP set up in less than 2 minutes
> * Weighs only 10 grams and is 2" long
> * Permits CPAP without interruption during transport

## How I built it
The prototypes were 3D-printed under lockdown with the following setup:

> * Machine: Ender3 Pro
> * Nozzle size: 0.4 mm
> * Layer height: 0.28 mm
> * Support: only for the protruding tube.

Nevertheless, they were designed with injection molding in mind.

## Challenges I ran into
* Laminar flow imperfections: FDM prints have slight imperfections that keep the device from creating a good laminar flow, but this doesn't seem to affect the performance of the device.
* Lack of proper pressure tests: the prototypes were developed **under lockdown** and without access to pressurized air for testing, so they had to be tested with water and in precarious conditions.
* Forming a team: finally I couldn't find any team members because I needed very specific skills (like CFD) and this platform isn't good at all matching people for engineering projects; from the 10 requests I sent, I had zero answers.
* Promoting the idea: my video editing, technical writing and marketing skills are subpar.

## Accomplishments that I'm proud of
* The device prototype was tested with the shower hose and a glove as a test lung, with extremely successful results: a maximum output pressure of **20 cmH2O** with a maximum input flow rate of **4.25 litres per minute**, and these parameters can be tuned by adjusting the shape of the device.
* This project includes an OpenSCAD library of parametric pneumatic conical fittings as per **ISO5356-1** that can be useful in dozens of other projects which need to interact with ventilator components.
* Some of the latest iterations of the device were designed with injection molding in mind, so they can be mass-produced in a pretty scalable fashion.

## What I learned
Lots of things, in many different fields: from fluid dynamics to constructive solid geometry.

## What's next for Georges CPAP
* Run proper air-based artificial lung tests and a computer-based fluid simulation with OpenFOAM.
* Use the aforementioned tests to optimize the device calibration and mass-manufacture it through injection molding.

## License
[**CERN-OHL-P**](https://ohwr.org/project/cernohl/wikis/Documents/CERN-OHL-version-2)

<!--
## Rant
I don't speak hackathonese, and this project's video simply shows the device working without bells nor whistles. Please take in account that my marketing/branding skills are nonexistent and my team search was unsuccessful.
-->
-->
