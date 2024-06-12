//
//  FireworksParticleView.swift
//  FireWorks Experiment
//
//  Created by Robert J Alessi on 6/1/24.
//

import UIKit

class FireworksParticleView:UIView {
    
    var particleImage:UIImage?
    var flareImage:UIImage?
    
    override class var layerClass:AnyClass {
        return CAEmitterLayer.self
    }
    
    /*
     * Invisible particle representing the rocket before the explosion
     * The particle is invisible because we do not assign an image to the
     * contents property of the cell
     */
    func makeEmitterCellRocket() -> CAEmitterCell {
        let cell = CAEmitterCell()
        /* -pi/2 = up  */
        cell.emissionLongitude = -.pi/2
        cell.emissionLatitude = 0
        cell.emissionRange = .pi/4
        cell.lifetime = 1.6
        //cell.birthRate = 1
        // Phase 10 adjustment 1 line
        cell.birthRate = 0.5
        
        /*
         * @note velocity - determines the speed of the particle, the higher the velocity
         * the further it travels on the screen. This is affected by yAcceleration
         *
         * @note yAcceleration - simulates gravity
         * a postive value applies gravity while negative value simulates a
         * lack or reduction of gravity allowing particles to "fly".
         * the combination of velocity & yAcceleration determines distance
         */
        cell.velocity = 50
        cell.velocityRange = cell.velocity/4
        cell.yAcceleration = -150
        // Note: Changing yAcceleration to -500 increase the fireworks' height to cover the whole screen.
        //       Leaving it at -150 will cover only one-third of the screen.
        //cell.yAcceleration = -500
        /*
         * @note color will get inherited by the cells in emitterCells array
         * @note red/green/blue ranges are the amount by which the color component
         * of the cell can vary
         * +/- 0.5 for a range between 0 to 1, giving a random color
         */
        let color = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        cell.color = color.cgColor
        //cell.redRange = 0.5
        //ell.greenRange = 0.5
        //cell.blueRange = 0.5
        // Phase 10 adjustment 3 lines
        cell.redRange = 255.0
        cell.greenRange = 255.0
        cell.blueRange = 255.0
        cell.name = "rocket"
        return cell
    }

    func makeEmitterCellFlare() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.color = UIColor.white.cgColor
        cell.contents = flareImage?.cgImage
        /*
         * the direction of emission, we need to rotate from the rocket's direction,
         * of -pi/2 (upward directions) 180 degrees, so pi radians is 180 degrees
         */
        cell.emissionLongitude = (2 * .pi)
        cell.birthRate = 45
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.scale = 0.3
        /*
         * simulates gravity, positive gravity pulls the emitter particles down
         */
        cell.yAcceleration = 350
        /*
         * 2pi = 360 degress, particles disperse in all directions
         */
        cell.emissionRange = .pi/7
        cell.alphaSpeed = -0.7
        cell.scaleSpeed = -0.1
        cell.scaleRange = 0.1
        cell.beginTime = 0.01
        /* needs to be long enough to stay with rocket */
        cell.duration = 2.0
        cell.name = "flare"
        return cell
    }
    
    func makeEmitterCellFirework() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = particleImage?.cgImage
        cell.birthRate = 8000
        cell.velocity = 130
        //cell.lifetime = 1.0
        // Phase 10 adjustment 1 line
        cell.lifetime = 2.0
        cell.emissionRange = (2 * .pi)
        /* determines size of explosion */
        cell.scale = 0.1
        cell.alphaSpeed = -0.2
        cell.yAcceleration = 80
        cell.beginTime = 1.5
        cell.duration = 0.1
        
        cell.scaleSpeed = -0.015
        cell.spin = 2
        cell.name = "firework"
        return cell
    }
    
    /*
     * preSpark is an invisible particle used to later emit the sparkle
     **/
    func makeEmitterCellPrespark(firework:CAEmitterCell) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 80
        cell.velocity = firework.velocity * 0.70
        cell.lifetime = 1.2
        cell.yAcceleration = firework.yAcceleration * 0.85
        cell.beginTime = firework.beginTime - 0.2
        cell.emissionRange = firework.emissionRange
        cell.greenSpeed = 100
        cell.blueSpeed = 100
        cell.redSpeed = 100
        cell.name = "preSpark"
        return cell
    }
    
    /* The 'sparkle' at the end of a firework */
    func makeEmitterSparkle() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = particleImage?.cgImage
        cell.birthRate = 10
        cell.lifetime = 0.05
        cell.yAcceleration = 150
        cell.beginTime = 0.8
        cell.scale = 0.05
        return cell
    }
    
    override func layoutSubviews() {
        let emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.maxY)
        emitter.emitterSize = CGSize(width: bounds.size.width * 0.50, height: 1.0)
        emitter.renderMode = .additive
        let rocket = makeEmitterCellRocket()
        let flare = makeEmitterCellFlare()
        let firework = makeEmitterCellFirework()
        let sparkle = makeEmitterSparkle()
        let prespark = makeEmitterCellPrespark(firework:firework)
        prespark.emitterCells = [sparkle]
        rocket.emitterCells = [flare, firework, prespark]
        emitter.emitterCells = [rocket]
    }
}
