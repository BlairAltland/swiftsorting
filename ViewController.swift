//
//  ViewController.swift
//  sortTesting
//
//  Created by Blair Altland on 2/22/18.
//  Copyright © 2018 Blair Altland. All rights reserved.
//

import Cocoa
import GameKit

class ViewController: NSViewController {
    
    
    @IBOutlet weak var sort: NSButton!
    @IBOutlet weak var number: NSTextField!
    @IBOutlet weak var quick: NSTextField!
    @IBOutlet weak var merge: NSTextField!
    @IBOutlet weak var selection: NSTextField!
    @IBOutlet weak var insertion: NSTextField!
    
    var startTime: TimeInterval = 0
    var endTime: TimeInterval = 0
    var shuffledArray: [Int] = []
    var shuffledArray2: [Int] = []
    var shuffledArray3: [Int] = []
    var shuffledArray4: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SortArray(_ sender: Any) {
        
        sortArrayForNumberOfValues(numbers: 100000)
        sortArrayForNumberOfValues(numbers: 500000)
        sortArrayForNumberOfValues(numbers: 750000)
        sortArrayForNumberOfValues(numbers: 1000000)
        sortArrayForNumberOfValues(numbers: 1125000)
    }
    
    func sortArrayForNumberOfValues(numbers: Int) {
        startTime = NSDate().timeIntervalSinceReferenceDate
        shuffledArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: Array(1 ... numbers)) as! [Int]
        endTime = NSDate().timeIntervalSinceReferenceDate
        print(endTime-startTime)
        
        startTime = NSDate().timeIntervalSinceReferenceDate
        shuffledArray2 = shuffledArray
        shuffledArray3 = shuffledArray
        shuffledArray4 = shuffledArray
        endTime = NSDate().timeIntervalSinceReferenceDate
        print(endTime-startTime)
        
        startTime = NSDate().timeIntervalSinceReferenceDate
        _ = quicksort(shuffledArray3)
        endTime = NSDate().timeIntervalSinceReferenceDate
        //print(newArray2)
        print("Quick Sort time @ \(numbers): \(endTime-startTime)")
        quick.doubleValue = endTime-startTime
        
        startTime = NSDate().timeIntervalSinceReferenceDate
        _ = mergeSort(shuffledArray2)
        endTime =  NSDate().timeIntervalSinceReferenceDate
        //print(newArray2)
        print("Merge Sort time @ \(numbers): \(endTime-startTime)")
        merge.doubleValue = endTime-startTime
        
        startTime = NSDate().timeIntervalSinceReferenceDate
        _ = selectionSort(shuffledArray3)
        endTime = NSDate().timeIntervalSinceReferenceDate
        //print(newArray2)
        print("Selection Sort time @ \(numbers): \(endTime-startTime)")
        selection.doubleValue = endTime-startTime
        
        startTime = NSDate().timeIntervalSinceReferenceDate
        _ = insertionSort(a: shuffledArray4)
        endTime = NSDate().timeIntervalSinceReferenceDate
        //print(newArray2)
        print("Insertion Sort time @ \(numbers): \(endTime-startTime)")
        insertion.doubleValue = endTime-startTime
    }
    
    func selectionSort<T: Comparable>(_ array: [T]) -> [T] {
        
        //check to see if the array = 1
        var array = array
        guard array.count > 1 else { return array }
        
        //Loop through all the elements in the array
        for n in 0 ..< array.count - 1 {
            //number.stringValue = "\(n)"
            //print("\(n)")
            var low = n
            for m in n + 1 ..< array.count {
                if array[m] < array[low] {
                    low = m
                }
            }
            
            if n != low {
                array.swapAt(n, low)
            }
        }
        return array
    }

    func insertionSort(a: [Int]) -> [Int] {
        guard a.count > 1 else { return a } // If have 1 or less items, we're already finished
        
        var b = a
        for i in 1..<b.count {
            var y = i
            while y > 0 && b[y] < b[y - 1] {
                b.swapAt(y - 1, y)
                y -= 1
            }
        }
        return b
    }
    func mergeSort(_ array: [Int]) -> [Int] {
        guard array.count > 1 else { return array }
        
        let middle = array.count / 2
        let leftArray = mergeSort(Array(array[0..<middle]))
        let rightArray = mergeSort(Array(array[middle..<array.count]))
        return merge(leftArray: leftArray, rightArray: rightArray)
    }
    
    func merge(leftArray: [Int], rightArray: [Int]) -> [Int] {
        
        var left = 0
        var right = 0
        var orderedArray = [Int]()
        
        while left < leftArray.count && right < rightArray.count {
            if leftArray[left] < rightArray[right] {
                orderedArray.append(leftArray[left])
                left =  left + 1
            } else if leftArray[left] > rightArray[right] {
                orderedArray.append(rightArray[right])
                right = right + 1
            } else {
                orderedArray.append(leftArray[left])
                left =  left + 1
                orderedArray.append(rightArray[right])
                right = right + 1
            }
        }
        
        while left < leftArray.count {
            orderedArray.append(leftArray[left])
            left =  left + 1
        }
        
        while right < rightArray.count {
            orderedArray.append(rightArray[right])
            right = right + 1
        }
        
        //print(orderedArray)
        return orderedArray
    }
    
    func quicksort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        
        let pivot = array[array.count/2]
        let less = array.filter { $0 < pivot }
        let equal = array.filter { $0 == pivot }
        let greater = array.filter { $0 > pivot }
        
        return quicksort(less) + equal + quicksort(greater)
    }
}



