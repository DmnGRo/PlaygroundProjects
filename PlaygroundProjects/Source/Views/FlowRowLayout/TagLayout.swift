//
//  TagLayout.swift
//  PlaygroundProjects
//
//  Created by Damien Rosa on 13/02/2025.
//

import SwiftUI

struct TagLayout: Layout {
    
    var alignment: Alignment = .center
    
    var spacing: CGFloat = 10
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth: CGFloat = proposal.width ?? 0
        var height: CGFloat = 0
        let rows = self.generateRows(maxWidth, proposal, subviews)
        
        for (index, row) in rows.enumerated() {
            if index == (rows.count - 1) {
                height += row.maxHeight(proposal: proposal)
            } else {
                height += row.maxHeight(proposal: proposal) + self.spacing
            }
        }
        
        return .init(width: maxWidth, height: height)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var origin = bounds.origin
        let maxWidth = bounds.width
        let rows = self.generateRows(maxWidth, proposal, subviews)
        
        for row in rows {
            origin.x = self.resetOriginX(self.alignment, bounds, maxWidth, row, proposal)
             for view in row {
                let viewSize = view.sizeThatFits(proposal)
                 view.place(at: origin, proposal: proposal)
                 origin.x += (viewSize.width + self.spacing)
            }
            origin.y += (row.maxHeight(proposal: proposal) + self.spacing)
        }
    }
    
    private func resetOriginX(_ alignment: Alignment, _ rect: CGRect, _ maxWidth: CGFloat, _ row: [LayoutSubviews.Element], _ proposal: ProposedViewSize) -> CGFloat {
        let leading: CGFloat = rect.maxX - maxWidth
        let trailing: CGFloat = rect.maxX - self.calculateRowWidth(row, proposal)
        switch alignment {
        case .leading:
            return leading
        case .trailing:
            return trailing
        case .center:
            return (trailing + leading) / 2
        default:
            return leading
        }
    }
    
    private func calculateRowWidth(_ row: [LayoutSubviews.Element], _ proposal: ProposedViewSize) -> CGFloat {
        row.reduce(CGFloat.zero) { partialResult, view in
            let width = view.sizeThatFits(proposal).width
            if view == row.last {
                return partialResult + width
            }
            return partialResult + width + self.spacing
        }
    }
    
    func generateRows(_ maxWidth: CGFloat, _ proposal: ProposedViewSize, _ subViews: Subviews) -> [[LayoutSubviews.Element]] {
        var rows: [[LayoutSubviews.Element]] = []
        var row: [LayoutSubviews.Element] = []
        
        var origin = CGRect.zero.origin
        
        for view in subViews {
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + self.spacing) > maxWidth {
                rows.append(row)
                row.removeAll()
                origin.x = 0
                
                row.append(view)
                origin.x += (viewSize.width + self.spacing)
            } else {
                row.append(view)
                origin.x += (viewSize.width + self.spacing)
            }
        }
        if !row.isEmpty {
            rows.append(row)
            row.removeAll()
        }
        return rows
    }
}

extension [LayoutSubviews.Element] {
    func maxHeight(proposal: ProposedViewSize) -> CGFloat {
        return self.compactMap { view in
            return view.sizeThatFits(proposal).height
        }.max() ?? 0
    }
}

#Preview {
    FlowRowLayoutView()
}
